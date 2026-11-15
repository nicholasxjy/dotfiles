import assert from "node:assert/strict";
import test from "node:test";
import promptTimeExtension from "./index.ts";

function setup(t) {
  const handlers = new Map();
  const statuses = [];
  const timers = new Set();
  let now = 0;
  t.mock.method(performance, "now", () => now);
  t.mock.method(globalThis, "setInterval", (callback, interval) => {
    assert.equal(interval, 1000);
    const timer = { callback, unref() {} };
    timers.add(timer);
    return timer;
  });
  t.mock.method(globalThis, "clearInterval", (timer) => timers.delete(timer));
  const ctx = {
    mode: "tui",
    hasUI: true,
    ui: {
      theme: { fg: (_color, text) => text },
      setStatus: (key, value) => statuses.push({ key, value }),
    },
  };
  promptTimeExtension({ on: (name, handler) => handlers.set(name, handler) });
  return {
    ctx, statuses, timers,
    emit: (name, event = {}) => handlers.get(name)?.(event, ctx),
    advance: (milliseconds) => {
      now += milliseconds;
      for (const timer of timers) timer.callback();
    },
  };
}

test("times the whole prompt across tool turns and retries, retaining the final duration", (t) => {
  const app = setup(t);
  app.emit("before_agent_start", { messageType: "user" });
  assert.deepEqual(app.statuses.at(-1), { key: "prompt-time", value: "prompt 0s" });
  app.advance(12_300);
  assert.equal(app.statuses.at(-1).value, "prompt 12s");
  app.emit("turn_end");
  app.emit("agent_end");
  app.emit("agent_start");
  app.emit("before_agent_start", { messageType: "custom" });
  app.advance(50_000);
  assert.equal(app.statuses.at(-1).value, "prompt 1m 2s");
  app.emit("agent_settled", { aborted: false });
  assert.equal(app.timers.size, 0);
  app.advance(10_000);
  assert.equal(app.statuses.at(-1).value, "prompt 1m 2s");

  app.emit("before_agent_start", { messageType: "user" });
  assert.equal(app.statuses.at(-1).value, "prompt 0s");
  app.advance(2500);
  app.emit("agent_settled", { aborted: true });
  assert.equal(app.statuses.at(-1).value, "prompt 2s");
  assert.equal(app.timers.size, 0);
});

test("replaces active timers and cleans up on reload, tree navigation, or shutdown", (t) => {
  const app = setup(t);
  for (const event of ["session_start", "session_tree", "session_shutdown"]) {
    app.emit("before_agent_start", { messageType: "user" });
    app.advance(5000);
    app.emit("before_agent_start", { messageType: "user" });
    assert.equal(app.timers.size, 1);
    assert.equal(app.statuses.at(-1).value, "prompt 0s");
    app.emit(event);
    assert.equal(app.timers.size, 0);
    assert.deepEqual(app.statuses.at(-1), { key: "prompt-time", value: undefined });
  }
});

test("ignores custom runs and non-terminal contexts", (t) => {
  const app = setup(t);
  app.emit("before_agent_start", { messageType: "custom" });
  for (const [mode, hasUI] of [["rpc", true], ["print", false], ["tui", false]]) {
    Object.assign(app.ctx, { mode, hasUI });
    app.emit("before_agent_start", { messageType: "user" });
    app.emit("agent_settled");
    app.emit("session_shutdown");
  }
  assert.equal(app.timers.size, 0);
  assert.equal(app.statuses.length, 0);
});

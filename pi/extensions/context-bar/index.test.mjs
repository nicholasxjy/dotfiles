import assert from "node:assert/strict";
import test from "node:test";
import contextBarExtension from "./index.ts";

function setup() {
  const handlers = new Map();
  const statuses = [];
  let usage = { contextWindow: 1000, percent: 30 };
  const ctx = {
    mode: "tui",
    hasUI: true,
    getContextUsage: () => usage,
    ui: {
      theme: { fg: (color, text) => `${color}:${text}` },
      setStatus: (key, value) => statuses.push({ key, value }),
    },
  };
  contextBarExtension({ on: (name, handler) => handlers.set(name, handler) });
  return {
    ctx,
    statuses,
    setUsage: (value) => { usage = value; },
    emit: (name, event = {}) => handlers.get(name)(event, ctx),
  };
}

test("renders context usage, thresholds, overflow, and unknown usage", () => {
  const app = setup();
  for (const [percent, expected] of [
    [0, "accent:ctx [□□□□□□□□□□] 0%"],
    [30, "accent:ctx [■■■□□□□□□□] 30%"],
    [70, "accent:ctx [■■■■■■■□□□] 70%"],
    [71, "warning:ctx [■■■■■■■□□□] 71%"],
    [91, "error:ctx [■■■■■■■■■□] 91%"],
    [100, "error:ctx [■■■■■■■■■■] 100%"],
    [125, "error:ctx [■■■■■■■■■■] 125%"],
    [null, "dim:ctx [??????????] ?"],
    [NaN, "dim:ctx [??????????] ?"],
  ]) {
    app.setUsage({ contextWindow: 1000, percent });
    app.emit("turn_end");
    assert.deepEqual(app.statuses.at(-1), { key: "context-bar", value: expected });
  }
  app.setUsage(undefined);
  app.emit("model_select");
  assert.equal(app.statuses.at(-1).value, "dim:ctx [??????????] ?");
});

test("updates during streaming and session changes, then clears on shutdown", () => {
  const app = setup();
  app.emit("session_start");
  app.emit("turn_start");
  assert.equal(app.statuses.length, 1);
  const message = {
    role: "assistant",
    stopReason: "stop",
    usage: { input: 200, output: 50, cacheRead: 200, cacheWrite: 50 },
  };
  app.emit("message_update", { message });
  assert.equal(app.statuses.at(-1).value, "accent:ctx [■■■■■□□□□□] 50%");
  app.emit("message_update", { message: { ...message, stopReason: "error" } });
  app.emit("message_update", { message: { ...message, stopReason: "aborted" } });
  assert.equal(app.statuses.length, 2);

  app.setUsage({ contextWindow: 2000, percent: 25 });
  app.emit("model_select");
  app.emit("message_update", { message });
  assert.equal(app.statuses.at(-1).value, "accent:ctx [■■■□□□□□□□] 25%");

  app.setUsage({ contextWindow: 2000, percent: null });
  app.emit("session_compact");
  assert.equal(app.statuses.at(-1).value, "dim:ctx [??????????] ?");
  for (const event of ["session_tree", "turn_end", "agent_end", "session_start"]) {
    app.setUsage({ contextWindow: 2000, percent: 10 });
    app.emit(event);
    assert.equal(app.statuses.at(-1).value, "accent:ctx [■□□□□□□□□□] 10%");
  }
  app.emit("session_shutdown");
  assert.deepEqual(app.statuses.at(-1), { key: "context-bar", value: undefined });
});

test("does not access context usage or publish statuses outside the terminal UI", () => {
  const app = setup();
  app.ctx.getContextUsage = () => { throw new Error("unexpected usage access"); };
  for (const [mode, hasUI] of [["rpc", true], ["print", false], ["tui", false]]) {
    Object.assign(app.ctx, { mode, hasUI });
    app.emit("session_start");
    app.emit("turn_end");
    app.emit("session_shutdown");
  }
  assert.equal(app.statuses.length, 0);
});

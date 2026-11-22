import assert from "node:assert/strict";
import test from "node:test";
import contextBarExtension from "./index.ts";

function setup() {
  const handlers = new Map();
  const statuses = [];
  let usage = { contextWindow: 1000, tokens: 300, percent: 30 };
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
  for (const [percent, tokens, expected] of [
    [0, 0, "accent:ctx [□□□□□□□□□□] 0% (0/100K)"],
    [30.2, 30200, "accent:ctx [■■■□□□□□□□] 30% (30.2K/100K)"],
    [70, 70000, "accent:ctx [■■■■■■■□□□] 70% (70K/100K)"],
    [71, 71000, "warning:ctx [■■■■■■■□□□] 71% (71K/100K)"],
    [91, 91000, "error:ctx [■■■■■■■■■□] 91% (91K/100K)"],
    [100, 100000, "error:ctx [■■■■■■■■■■] 100% (100K/100K)"],
    [125, 125000, "error:ctx [■■■■■■■■■■] 125% (125K/100K)"],
    [null, null, "dim:ctx [??????????] ?"],
    [NaN, 0, "dim:ctx [??????????] ?"],
  ]) {
    app.setUsage({ contextWindow: 100000, tokens, percent });
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
  assert.equal(app.statuses.at(-1).value, "accent:ctx [■■■■■□□□□□] 50% (500/1K)");
  app.emit("message_update", { message: { ...message, usage: { ...message.usage, output: 51 } } });
  assert.equal(app.statuses.at(-1).value, "accent:ctx [■■■■■□□□□□] 50% (501/1K)");
  app.emit("message_update", { message: { ...message, stopReason: "error" } });
  app.emit("message_update", { message: { ...message, stopReason: "aborted" } });
  assert.equal(app.statuses.length, 3);

  app.setUsage({ contextWindow: 2000, tokens: 500, percent: 25 });
  app.emit("model_select");
  app.emit("message_update", { message });
  assert.equal(app.statuses.at(-1).value, "accent:ctx [■■■□□□□□□□] 25% (500/2K)");

  app.setUsage({ contextWindow: 2000, tokens: null, percent: null });
  app.emit("session_compact");
  assert.equal(app.statuses.at(-1).value, "dim:ctx [??????????] ?");
  for (const event of ["session_tree", "turn_end", "agent_end", "session_start"]) {
    app.setUsage({ contextWindow: 2000, tokens: 200, percent: 10 });
    app.emit(event);
    assert.equal(app.statuses.at(-1).value, "accent:ctx [■□□□□□□□□□] 10% (200/2K)");
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

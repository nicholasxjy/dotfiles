import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";

const STATUS_KEY = "context-bar";

export default function contextBarExtension(pi: ExtensionAPI): void {
  let contextWindow = 0;
  let lastStatus: string | undefined;

  function render(ctx: ExtensionContext, percent: number | null | undefined): void {
    if (ctx.mode !== "tui" || !ctx.hasUI) return;

    const known = percent != null && Number.isFinite(percent);
    const filled = known ? Math.round(Math.max(0, Math.min(100, percent)) / 10) : 0;
    const bar = known ? "■".repeat(filled) + "□".repeat(10 - filled) : "?".repeat(10);
    const text = `ctx [${bar}] ${known ? `${Math.round(percent)}%` : "?"}`;
    const color = !known ? "dim" : percent > 90 ? "error" : percent > 70 ? "warning" : "accent";
    const status = ctx.ui.theme.fg(color, text);
    if (status !== lastStatus) {
      ctx.ui.setStatus(STATUS_KEY, status);
      lastStatus = status;
    }
  }

  function refresh(ctx: ExtensionContext): void {
    if (ctx.mode !== "tui" || !ctx.hasUI) return;
    const usage = ctx.getContextUsage();
    contextWindow = usage?.contextWindow ?? 0;
    render(ctx, usage?.percent);
  }

  pi.on("session_start", (_event, ctx) => {
    lastStatus = undefined;
    refresh(ctx);
  });
  pi.on("turn_start", (_event, ctx) => refresh(ctx));
  pi.on("turn_end", (_event, ctx) => refresh(ctx));
  pi.on("agent_end", (_event, ctx) => refresh(ctx));
  pi.on("model_select", (_event, ctx) => refresh(ctx));
  pi.on("session_tree", (_event, ctx) => refresh(ctx));
  pi.on("session_compact", (_event, ctx) => refresh(ctx));

  pi.on("message_update", (event, ctx) => {
    const message = event.message;
    if (message.role !== "assistant" || message.stopReason === "error" || message.stopReason === "aborted") return;
    const { input, output, cacheRead, cacheWrite } = message.usage;
    const tokens = input + output + cacheRead + cacheWrite;
    if (contextWindow > 0 && tokens > 0) render(ctx, (tokens / contextWindow) * 100);
  });

  pi.on("session_shutdown", (_event, ctx) => {
    if (ctx.mode === "tui" && ctx.hasUI) ctx.ui.setStatus(STATUS_KEY, undefined);
  });
}

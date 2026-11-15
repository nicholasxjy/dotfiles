import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";

const STATUS_KEY = "prompt-time";

export default function promptTimeExtension(pi: ExtensionAPI): void {
  let startedAt: number | undefined;
  let timer: ReturnType<typeof setInterval> | undefined;

  function stop(): void {
    if (timer) clearInterval(timer);
    timer = undefined;
    startedAt = undefined;
  }

  function refresh(ctx: ExtensionContext): void {
    if (startedAt === undefined) return;
    const seconds = Math.floor((performance.now() - startedAt) / 1000);
    const duration = seconds < 60 ? `${seconds}s` : `${Math.floor(seconds / 60)}m ${seconds % 60}s`;
    ctx.ui.setStatus(STATUS_KEY, ctx.ui.theme.fg("dim", `prompt ${duration}`));
  }

  function reset(ctx: ExtensionContext): void {
    stop();
    if (ctx.mode === "tui" && ctx.hasUI) ctx.ui.setStatus(STATUS_KEY, undefined);
  }

  pi.on("before_agent_start", (event, ctx) => {
    if (event.messageType === "custom" || ctx.mode !== "tui" || !ctx.hasUI) return;
    stop();
    startedAt = performance.now();
    refresh(ctx);
    timer = setInterval(() => refresh(ctx), 1000);
    timer.unref();
  });

  pi.on("agent_settled", (_event, ctx) => {
    refresh(ctx);
    stop();
  });

  pi.on("session_start", (_event, ctx) => reset(ctx));
  pi.on("session_tree", (_event, ctx) => reset(ctx));
  pi.on("session_shutdown", (_event, ctx) => reset(ctx));
}

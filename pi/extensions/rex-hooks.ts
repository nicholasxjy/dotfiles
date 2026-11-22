import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function rexHooks(pi: ExtensionAPI): void {
  let startupContext = "";

  pi.on("session_start", async (_event, ctx) => {
    const result = await pi.exec("rex", ["__internal", "session-start", "--agent", "pi"], {
      cwd: ctx.cwd,
      timeout: 5_000,
    });
    startupContext = result.code === 0 && !result.killed ? result.stdout.trim() : "";
  });

  pi.on("before_agent_start", (event) => {
    if (startupContext) {
      event.systemPromptOptions.sections.rex_session = startupContext;
    }
  });
}

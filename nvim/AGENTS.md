# AGENTS.md

This file gives project-specific instructions for agents working in
`/Users/nick/.config/nvim`.

## Project Shape

This is a personal Neovim configuration written in Lua. It targets modern
Neovim with the built-in `vim.pack` plugin manager.

- `init.lua` is the startup entrypoint. Keep it small and ordered.
- `lua/options.lua` owns global editor options.
- `lua/keymaps.lua` owns global keymaps and the local keymap helper.
- `lua/autocmds.lua` owns user commands and general autocommands.
- `lua/pack.lua` owns plugin source declarations and eager/lazy pack loading.
- `lua/lsp.lua` owns diagnostics, LSP enablement, and LSP keymaps.
- `lua/util.lua` owns shared helpers such as deferred plugin setup and pack
  build hooks.
- `lua/ui.lua` owns shared icons and visual constants.
- `plugin/*.lua` contains plugin-specific setup. Prefer adding plugin config
  there instead of growing `init.lua`.
- `ftplugin/*.lua` contains filetype-specific behavior.
- `nvim-pack-lock.json` is generated plugin lock state. Do not hand-edit it.

## Editing Rules

- Use Lua idioms already present in the config: local helpers, `vim.*` APIs,
  `vim.api.nvim_create_autocmd`, `vim.keymap.set`, and `vim.tbl_extend`.
- Keep modules focused. Add a new plugin to `lua/pack.lua`, then configure it
  in a matching `plugin/<name>.lua` file unless the configuration is truly
  shared.
- Prefer lazy/deferred setup for optional or expensive plugins. Existing
  patterns include `util.ensure_plugin`, `util.packadd`, `util.build_*_on_change`,
  `vim.schedule`, and one-shot autocommands.
- Avoid introducing new plugin managers or dependency frameworks. This config
  uses `vim.pack`, not lazy.nvim.
- Keep keymap descriptions accurate and concise. Preserve the space leader.
- Be careful with startup performance: avoid unconditional `require()` calls for
  plugins that are meant to load lazily.
- Do not remove user-specific paths or runtime assumptions unless the task is
  explicitly to make the config portable.
- Do not edit generated or machine-managed files unless the task requires it.
  In particular, leave `nvim-pack-lock.json` alone unless updating plugins.

## Style

- Format Lua with Stylua using `stylua.toml`.
- Use 2-space indentation and keep lines near the configured 120-column width.
- Prefer clear local functions over broad abstractions.
- Comments should explain non-obvious behavior or constraints, not restate the
  code.

## Verification

For small Lua/config edits, run the lightest check that proves startup still
loads:

```sh
nvim --headless "+lua vim.health.start('config'); vim.health.ok('loaded')" +qa
```

For formatting-sensitive changes, run:

```sh
stylua --check .
```

When changing plugin declarations or plugin build hooks, also validate inside
Neovim with relevant `:PackUpdate`, `:PackCheck`, or direct startup/load checks.
Do not claim plugin updates are complete unless the command was actually run.

## Safety

- This directory may not be a Git repository. Check before relying on Git.
- Preserve unrelated local edits.
- Avoid destructive cleanup of installed packs, caches, Mason packages, or lock
  files unless the user explicitly asks for it.
- If a command would require network access, explain the need through the tool
  escalation path and keep the requested command scoped.

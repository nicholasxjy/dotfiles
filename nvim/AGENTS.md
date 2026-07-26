# AGENTS.md

This file gives project-specific instructions for agents working in
`$HOME/.config/nvim`.

## Project Shape

This is a personal Neovim configuration written in Lua. It targets modern
Neovim with the `lazy.nvim` plugin manager.

- `init.lua` is the startup entrypoint. Keep it small and ordered.
- `lua/options.lua` owns global editor options.
- `lua/keymaps.lua` owns global keymaps and the local keymap helper.
- `lua/autocmds.lua` owns user commands and general autocommands.
- `lua/pack.lua` owns the `lazy.nvim` bootstrap and plugin declarations.
- `lua/lsp.lua` owns diagnostics, LSP enablement, and LSP keymaps.
- `lua/ui.lua` owns shared icons and visual constants.
- `plugin/*.lua` contains plugin-specific setup. Prefer adding plugin config
  there instead of growing `init.lua`; when behavior depends on project-local
  config files, gate it on those files instead of applying it globally.
- `ftplugin/*.lua` contains filetype-specific behavior.
- `lazy-lock.json` is generated plugin lock state. Do not hand-edit it.

## Editing Rules

- Use Lua idioms already present in the config: local helpers, `vim.*` APIs,
  `vim.api.nvim_create_autocmd`, `vim.keymap.set`, and `vim.tbl_extend`.
- Keep modules focused. Add a new plugin spec to `lua/pack.lua`, then configure
  it in a matching `plugin/<name>.lua` file unless the configuration is truly
  shared.
- Prefer lazy/deferred setup for optional or expensive plugins. Existing
  patterns include `vim.schedule` and one-shot autocommands.
- Avoid introducing new plugin managers or dependency frameworks. This config
  uses `lazy.nvim`.
- Keep keymap descriptions accurate and concise. Preserve the space leader.
- Be careful with startup performance: avoid unconditional `require()` calls for
  plugins that are meant to load lazily.
- Do not remove user-specific paths or runtime assumptions unless the task is
  explicitly to make the config portable.
- Do not edit generated or machine-managed files unless the task requires it.
  In particular, leave `lazy-lock.json` alone unless updating plugins.

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
Neovim with relevant `:Lazy sync`, `:Lazy check`, or direct startup/load checks.
Do not claim plugin updates are complete unless the command was actually run.

## Safety

- This directory may not be a Git repository. Check before relying on Git.
- Preserve unrelated local edits.
- Avoid destructive cleanup of installed packs, caches, Mason packages, or lock
  files unless the user explicitly asks for it.
- In particular, leave `lazy-lock.json` alone unless updating plugins.
- If a command would require network access, explain the need through the tool
  escalation path and keep the requested command scoped.

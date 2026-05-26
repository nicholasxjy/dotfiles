# AGENTS.md

This file gives project-specific instructions for agents working in
`/Users/nick/.config/nvim`.

## Project Shape

This is a personal Neovim configuration written in Lua. It targets modern
Neovim with `folke/lazy.nvim` as the plugin manager.

- `init.lua` is the startup entrypoint. Keep it small and ordered.
- `lua/options.lua` owns global editor options.
- `lua/keymaps.lua` owns global keymaps and the local keymap helper.
- `lua/autocmds.lua` owns user commands and general autocommands.
- `lua/pack.lua` owns lazy.nvim bootstrap and setup.
- `lua/lsp.lua` owns diagnostics, LSP enablement, and LSP keymaps.
- `lua/util.lua` owns shared non-plugin helpers.
- `lua/ui.lua` owns shared icons and visual constants.
- `lua/plugins/*.lua` contains lazy.nvim plugin specs and plugin-specific
  setup. Prefer adding plugin config there instead of growing `init.lua`.
- `ftplugin/*.lua` contains filetype-specific behavior.
- `lazy-lock.json` and the legacy `nvim-pack-lock.json` are generated plugin
  lock state. Do not hand-edit them.

## Editing Rules

- Use Lua idioms already present in the config: local helpers, `vim.*` APIs,
  `vim.api.nvim_create_autocmd`, `vim.keymap.set`, and `vim.tbl_extend`.
- Keep modules focused. Add a new plugin in a focused `lua/plugins/*.lua` spec
  file unless the configuration is truly shared.
- Prefer lazy/deferred setup for optional or expensive plugins. Existing
  patterns include lazy.nvim `event`, `cmd`, `ft`, `keys`, `opts`,
  `dependencies`, and `build`, plus `vim.schedule` and one-shot autocommands.
- Avoid introducing new plugin managers or dependency frameworks. This config
  uses lazy.nvim, not `vim.pack`.
- Keep keymap descriptions accurate and concise. Preserve the space leader.
- Be careful with startup performance: avoid unconditional `require()` calls for
  plugins that are meant to load lazily.
- Do not remove user-specific paths or runtime assumptions unless the task is
  explicitly to make the config portable.
- Do not edit generated or machine-managed files unless the task requires it.
  In particular, leave plugin lock files alone unless updating plugins.

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
Neovim with relevant `:Lazy` checks or direct startup/load checks. Do not claim
plugin updates are complete unless the command was actually run.

## Safety

- This directory may not be a Git repository. Check before relying on Git.
- Preserve unrelated local edits.
- Avoid destructive cleanup of installed packs, caches, Mason packages, or lock
  files unless the user explicitly asks for it.
- If a command would require network access, explain the need through the tool
  escalation path and keep the requested command scoped.

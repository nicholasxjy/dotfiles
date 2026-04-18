# AGENTS.md

This repository is a **Neovim configuration** written in **Lua**, organized as a modular `lua/` tree and managed with **lazy.nvim**.

## Quick orientation

Entry points:
- `init.lua` → loads core + theme (`init.lua:1-2`)
- `lua/core/init.lua` → loads options, lazy.nvim, keymaps, autocmds (`lua/core/init.lua:1-4`)
- Plugin manager bootstrap + setup: `lua/core/lazy.lua` (`lua/core/lazy.lua:1-41`)

Top-level layout:
- `lua/core/` — editor configuration (options, keymaps, autocmds, UI glue)
- `lua/plugins/` — lazy.nvim plugin specs (one file per topic/plugin family)
- `lua/utils/` — shared helpers used by core/plugins (e.g. `lsp.lua`, `mini.lua`, `snippets.lua`)
- `lsp/` — per-server LSP settings (Lua modules)
- `ftplugin/` — filetype-specific configuration
- `snippets/` — custom LuaSnip snippet definitions (per-filetype)

## Essential commands (observed)

This repo is meant to be exercised from Neovim.

### Neovim
- Check Neovim version:
  - `nvim --version`

### Plugin manager (lazy.nvim)
- lazy.nvim is bootstrapped automatically on startup via git clone:
  - see `lua/core/lazy.lua:1-7`
- Inside Neovim:
  - `:Lazy` (also mapped to `<leader>L`) - open lazy.nvim UI (`lua/core/keymaps.lua:55`)

### Tooling installer (mason.nvim)
- Mason is configured as a lazy.nvim plugin and is set to update via:
  - `build = ":MasonUpdate"` (`lua/plugins/mason.lua:3`)
- Inside Neovim:
  - `:Mason` (also mapped to `<leader>M` and `<leader>cm`) (`lua/core/keymaps.lua:56`, `lua/plugins/mason.lua:7`)

## Formatting & style

Lua formatting is configured via StyLua:
- `stylua.toml`:
  - spaces, 2-width indent (`stylua.toml:1-2`)
  - column width 120 (`stylua.toml:3`)
  - `sort_requires.enabled = true` (`stylua.toml:4-5`)

Conventions observed in code:
- Indentation: 2 spaces (also enforced via `vim.opt.tabstop/shiftwidth/expandtab`) (`lua/core/options.lua:34-39`)
- Keymaps are usually defined via a small wrapper `map(...)` around `vim.keymap.set` (`lua/core/keymaps.lua:1-12`)
- Plugin specs are returned as Lua tables from files under `lua/plugins/**`.

## Key configuration switches (globals)

Several global toggles are expected to exist:
- `<leader>` and `<localleader>` are set to space (`lua/core/options.lua:1-2`)
- `vim.g.bordered` controls UI borders for multiple UIs (`lua/core/options.lua:12`, `lua/core/lazy.lua:26`, `lua/plugins/mason.lua:13`, `lua/plugins/lspconfig.lua:20`)
- `vim.g.autoformat` default enabled (`lua/core/options.lua:3`)
- `vim.g.copilot_enabled` default disabled (`lua/core/options.lua:6`)

## Picker / fuzzy finding

Fuzzy finding uses **Snacks.picker** exclusively (fzf-lua has been removed):
- Picker config and keymaps: `lua/plugins/snacks.lua`
- LSP picker keymaps (definitions, references, diagnostics, etc.): `lua/utils/lsp.lua`
  - Uses a `pick(name, opts)` helper that calls `Snacks.picker[name](opts)`

## LSP architecture

LSP is configured with `nvim-lspconfig` and uses Neovim's newer `vim.lsp.enable(...)` flow:
- `lua/plugins/lspconfig.lua`:
  - Configures diagnostics UI and signs
  - Builds LSP client capabilities and extends them via `blink.cmp`
  - Enables a curated list of servers via `vim.lsp.enable({ ... })`
  - `LspAttach` autocmd delegates keymaps/setup to `utils.lsp.on_attach`
- `lua/utils/lsp.lua`:
  - `keymap_setup()` — global LSP keymaps (go-to-definition, references, diagnostics, etc.)
  - `methods_setup()` — per-buffer LSP features (inlay hints, linked editing, eslint auto-fix)

Per-server settings live under `lsp/` (e.g. `lsp/lua_ls.lua`, `lsp/gopls.lua`, etc.).

## Autocmds and buffer behavior

Autocmds are centralized in `lua/core/autocmds.lua`.
Notable behaviors:
- Some filetypes disable autoformat via buffer-local `vim.b.autoformat = false`:
  - `shell`, `bash`, `sh`, `java` (`lua/core/autocmds.lua:23-29`)
- Many "utility" filetypes are set to close with `q` and be unlisted (`lua/core/autocmds.lua:30-64`)
- Auto-create directories on save (`lua/core/autocmds.lua:128-137`)

## Testing

"Testing" in this repository is primarily Neovim/plugin-level behavior.
There is a neotest plugin spec and keymaps:
- `lua/plugins/test.lua` defines `nvim-neotest/neotest` and maps under `<leader>t` (`lua/plugins/test.lua:1-26`).

No external test runner or CI config was observed in the current tree.

## Adding/changing plugins

Pattern:
- Add or adjust plugin specs in `lua/plugins/*.lua`.
- lazy.nvim loads specs via a single import:
  - `{ import = "plugins" }` (`lua/core/lazy.lua`)

When changing plugin behavior:
- Prefer updating the plugin spec file responsible for that domain (e.g. LSP in `lua/plugins/lspconfig.lua`, Mason in `lua/plugins/mason.lua`).

## Gotchas / non-obvious details

- This config assumes a fairly recent Neovim; it uses `vim.uv`/`vim.loop` and `vim.lsp.enable(...)` (`lua/core/lazy.lua:3`, `lua/plugins/lspconfig.lua:70`).
- Borders are globally toggleable via `vim.g.bordered`; many UIs read it.
- Some default Neovim keybindings are explicitly removed to avoid `gr` delay (`lua/core/keymaps.lua:16-22`).

## Where to look for common tasks

- Change editor options: `lua/core/options.lua`
- Add/modify keymaps: `lua/core/keymaps.lua`
- Add/modify autocmds: `lua/core/autocmds.lua`
- Plugin manager settings/import order: `lua/core/lazy.lua`
- Picker / fuzzy finding: `lua/plugins/snacks.lua`
- LSP enablement/diagnostic UX: `lua/plugins/lspconfig.lua`
- LSP keymaps and attach logic: `lua/utils/lsp.lua`
- Per-language LSP settings: `lsp/*.lua`
- Filetype tweaks: `ftplugin/*.lua`
- Custom snippets: `snippets/*.lua`

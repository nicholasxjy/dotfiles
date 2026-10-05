# AGENTS.md

This file gives project-specific instructions for agents working in
`$HOME/.config/nvim`.

## Project Shape

This is a personal Neovim configuration written in Lua. It targets modern
Neovim with the built-in `vim.pack` plugin manager.

- `init.lua` is the startup entrypoint. Keep it small and ordered.
- `lua/options.lua` owns global editor options.
- `lua/keymaps.lua` owns global keymaps and the local keymap helper.
- `lua/autocmds.lua` owns user commands and general autocommands.
- `lua/pack.lua` owns plugin source declarations. `vim.pack.add()` runs with a
  no-op `load` hook: it installs and registers plugins but puts nothing on
  'runtimepath'. Every plugin is therefore loaded by the config that owns it.
- `lua/loader.lua` owns the loading primitives: `packadd` (idempotent
  `:packadd`), `on_very_lazy`, `defer`, `defer_buffer`, and the `User VeryLazy`
  event that fires one tick after `VimEnter`.
- `lua/lsp.lua` owns diagnostics, LSP enablement, LSP keymaps, and the shared
  `vim.lsp.config("*")` capabilities. It packadds blink.cmp eagerly.
- `lsp/*.lua` holds one native `vim.lsp.Config` per server, picked up by
  `vim.lsp.enable()`. `lua/lsp_util.lua` holds helpers shared by those files
  (SchemaStore injection, `package.json` field detection).
- `lua/util.lua` owns pack build hooks (`build_cmd_on_change`,
  `build_fn_on_change`).
- `lua/ui.lua` owns shared icons and visual constants.
- `lua/theme/` owns colorscheme setup (`theme.load(name)`). Cyberdream is the
  default; tokyonight is the fallback. Shared highlight overrides live there.
- `plugin/*.lua` groups plugin setup by domain:
  - `coding.lua`: blink.cmp, LuaSnip, lazydev, Tree-sitter, autopairs, matchup,
    illuminate, autotag, ts-comments.
  - `editor.lua`: which-key, mini.ai/surround/trailspace, treesj, todo-comments,
    and the on-demand translator.
  - `files.lua`: neo-tree (sidebar), mini.files (modal), Yazi, and Oil (with previews).
    Add file managers only when explicitly requested.
  - `git.lua`: gitsigns, differ, lazygit, and git pickers.
  - `languages.lua`: markdown, Rust (rustaceanvim, crates).
  - `navigation.lua`: smart-splits, flash, multicursor.
  - `search.lua`: fzf-lua, fzf-lua-smart, grug-far.
  - `tooling.lua`: mason, conform, nvim-lint.
  - `ui.lua`: theme, mini.icons, mini.notify, lualine, bufferline, statuscolumn,
    winbar, inline diagnostics.

  If a domain file grows too large, split it into `plugin/<domain>/*.lua` and
  load those files explicitly from the entrypoint. When behavior depends on
  project-local config files, gate it on those files instead of applying it
  globally.
- `ftplugin/*.lua` contains filetype-specific behavior (e.g. `java.lua` starts
  jdtls through nvim-jdtls).
- `nvim-pack-lock.json` is generated plugin lock state. Do not hand-edit it.

## Editing Rules

- Use Lua idioms already present in the config: local helpers, `vim.*` APIs,
  `vim.api.nvim_create_autocmd`, `vim.keymap.set`, and `vim.tbl_extend`.
- Keep modules focused. Add a new plugin to `lua/pack.lua`, then configure it
  in a matching plugin file or functional group under `plugin/` unless the
  configuration is truly shared.
- Every plugin added to `lua/pack.lua` needs a matching `loader.packadd(...)`
  somewhere, or it will never reach 'runtimepath'. Never call `vim.cmd.packadd`
  directly: a repeated `:packadd` re-sources the plugin's `plugin/` files.
- Pick the latest loading point that still works, in this order:
  - on first use, via a keymap or command stub that calls
    `loader.load(name, setup)`. Use this for rarely used tools and for plugins
    that need an external binary (examples: kd-translator, neo-tree,
    mini.files).
  - `loader.defer_buffer(name, setup, { schedule = true })`: needs a real file
    buffer but nothing on the first frame (gitsigns, conform, nvim-lint).
  - `loader.on_very_lazy(name, setup)`: user-driven features (keymaps,
    commands, pickers).
  - `loader.defer_buffer(name, setup)`: must decorate the first render
    (Tree-sitter highlights, winbar).
  - eager, at the top level of the `plugin/` file: only for things `lua/lsp.lua`
    or the first drawn frame depend on (colorscheme, mini.icons, mini.notify,
    blink.cmp capabilities, mason's `$PATH`).
- Never put global keymaps or commands behind `defer_buffer`. Starting `nvim`
  with no file (e.g. in a repo root) never fires it, so the keys would silently
  not exist.
- Set a plugin's `vim.g.*` options before its `loader.packadd(...)`, because
  many `plugin/` files read or default them when sourced.
- Plugins that need an external binary must check `vim.fn.executable(...)`
  before calling into the plugin, and warn only when the feature is used, not
  at startup.
- Extra LSP client capabilities go into `vim.lsp.config("*")` in `lua/lsp.lua`
  before blink.cmp is packadded; blink's `plugin/` file merges its own on top.
  Don't call `get_lsp_capabilities()` again. Clients started with
  `vim.lsp.start()`-style APIs (jdtls in `ftplugin/java.lua`) must apply
  `vim.lsp.config["*"].capabilities` themselves; rustaceanvim already does.
- Before adding a keymap, check that it doesn't duplicate a Nvim default (for
  example `]d`/`[d`, `gcc`) or an existing mapping, and that it isn't a prefix
  of another mapping (which adds a timeout delay).
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

- Format Lua with Stylua using `stylua.toml`. Stylua is installed by Mason;
  if it isn't on `$PATH`, use `~/.local/share/nvim/mason/bin/stylua`.
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

The health check above only proves `init.lua` and eager `plugin/` code load.
Deferred setups run after `VeryLazy` or on buffer events, so for changes to
deferred setups, run headless with a short `vim.defer_fn` probe and inspect
`:messages`. Test both `nvim --headless <file>` and `nvim --headless` with no
file. Then check that the expected modules are in `package.loaded` and the
expected keymaps exist (`vim.fn.maparg`).

To measure startup cost, compare `NVIM STARTED` in
`nvim --headless --startuptime <log> +qa`, with and without a file argument.

When changing plugin declarations or plugin build hooks, also validate inside
Neovim with relevant `:PackUpdate`, `:PackCheck`, or direct startup/load checks.
Removing a plugin from `lua/pack.lua` leaves it on disk as inactive. Tell the
user to run `:PackCheck` rather than deleting it yourself. Do not claim plugin
updates are complete unless the command was actually run.

## Safety

- This directory may not be a Git repository. Check before relying on Git.
- Preserve unrelated local edits.
- Avoid destructive cleanup of installed packs, caches, Mason packages, or lock
  files unless the user explicitly asks for it.
- If a command would require network access, explain the need through the tool
  escalation path and keep the requested command scoped.

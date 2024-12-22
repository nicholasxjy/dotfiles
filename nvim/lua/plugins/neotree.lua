return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.window = opts.window or {}
    opts.window.position = "right"
    opts.window.width = 35
    opts.filesystem = opts.filesystem or {}
    opts.filesystem.hijack_netrw_behavior = "disabled"
    opts.filesystem.filtered_items = {
      visible = true,
      show_hidden_count = true,
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_by_name = {
        "node_modules",
        ".husky",
        ".vscode",
      },
      never_show = {
        ".DS_Store",
        "thumb.db",
        ".git",
      },
    }

    opts.default_component_configs = opts.default_component_configs or {}
    opts.default_component_configs.git_status = {
      symbols = {
        -- Change type
        added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
        deleted = "", -- this can only be used in the git_status source
        renamed = "➜", -- this can only be used in the git_status source
        -- Status type
        untracked = "★",
        ignored = "◌",
        unstaged = "✗",
        staged = "✓",
        conflict = "",
      },
    }
    opts.default_component_configs.icon = {
      provider = function(icon, node)
        local text, hl
        local mini_icons = require("mini.icons")
        if node.type == "file" then
          text, hl = mini_icons.get("file", node.name)
        elseif node.type == "directory" then
          text, hl = mini_icons.get("directory", node.name)
          if node:is_expanded() then
            text = nil
          end
        end

        if text then
          icon.text = text
        end
        if hl then
          icon.highlight = hl
        end
      end,
    }
    opts.default_component_configs.kind_icon = {
      provider = function(icon, node)
        icon.text, icon.highlight = require("mini.icons").get("lsp", node.extra.kind.name)
      end,
    }

    opts.event_handlers = opts.event_handlers or {}
    table.insert(opts.event_handlers, {
      event = "file_open_requested",
      handler = function()
        require("neo-tree.command").execute({ action = "close" })
      end,
    })
  end,
}

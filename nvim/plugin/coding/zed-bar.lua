local loader = require("loader")

local setup = function()
  loader.packadd("zed-bar.nvim")

  local zed_bar = require("zed-bar")
  local default_enabled = require("zed-bar.config").defaults.enabled
  local group = vim.api.nvim_create_augroup("sjvim_zed_bar_reload", { clear = true })

  -- zed-bar renders on BufReadPre, while Tree-sitter still has stale node ranges.
  vim.api.nvim_create_autocmd("BufReadPre", {
    group = group,
    callback = function(args)
      vim.b[args.buf].sjvim_zed_bar_ready = false
    end,
  })
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = group,
    callback = function(args)
      vim.b[args.buf].sjvim_zed_bar_ready = true
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(args.buf) then
          zed_bar.refresh(args.buf)
        end
      end)
    end,
  })

  zed_bar.setup({
    enabled = function(buf, win)
      return default_enabled(buf, win) and vim.b[buf].sjvim_zed_bar_ready ~= false
    end,
  })
end

loader.defer_buffer("zed-bar", setup)

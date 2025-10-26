return {
  "Davidyz/inlayhint-filler.nvim",
  event = "LspAttach",
  opts = {
    blacklisted_servers = {},
    force = function(ctx)
      if vim.bo[ctx.bufnr].filetype == "rust" then
        return true
      end
      return false
    end,
    eager = function(ctx)
      return vim.bo[ctx.bufnr].filetype == "rust"
    end,
  },
  keys = {
    {
      "<Leader>if",
      function()
        if vim.lsp.inlay_hint.apply_text_edits ~= nil then
          vim.schedule(function()
            vim.notify("Using built-in API.")
            vim.lsp.inlay_hint.apply_text_edits()
          end)
        else
          require("inlayhint-filler").fill()
        end
      end,
      mode = { "n", "v" },
      desc = "[I]nlayhint [f]ill",
    },
  },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "echasnovski/mini.icons",
    },
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          local buf_clients = nil
          if vim.lsp.get_clients ~= nil then
            -- buf_get_client is deprecated in nvim >=0.10.0
            buf_clients = vim.lsp.get_clients({ bufnr = 0 })
          else
            buf_clients = vim.lsp.buf_get_clients()
          end
          local null_ls_installed, null_ls = pcall(require, "null-ls")
          local conform_installed, conform = pcall(require, "conform")
          local buf_client_names = {}

          for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" then
              table.insert(buf_client_names, client.name)
            end
          end

          if null_ls_installed then
            for _, source in ipairs(null_ls.get_source({ filetype = vim.bo.filetype })) do
              table.insert(buf_client_names, source.name)
            end
          end

          if conform_installed then
            local formatters = conform.list_formatters(0)
            for _, source in ipairs(formatters) do
              table.insert(buf_client_names, source.name)
            end
          end
          return "[" .. table.concat(buf_client_names, ",") .. "]"
        end,
        color = { fg = "#72BAA9", gui = "bold" },
        icon = "󰌘",
      })
    end,
  },
}

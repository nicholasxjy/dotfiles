return {
  "HiPhish/rainbow-delimiters.nvim",
  ft = {
    "html",
    "clojure",
    "query",
    "scheme",
    "lisp",
    "commonlisp",
    "php",
    "javascriptreact",
    "typescriptreact",
    "javascript",
    "typescript",
    "rust",
    "go",
    "lua",
  },
  config = function()
    require("rainbow-delimiters.setup").setup({
      query = {
        [""] = "rainbow-delimiters",
        javascript = "rainbow-delimiters",
        typescript = "rainbow-delimiters",
        tsx = "rainbow-delimiters",
        typescriptreact = "rainbow-delimiters",
        commonlisp = "rainbow-delimiters",
        scheme = "rainbow-delimiters",
        query = function(bufnr)
          -- Use blocks for read-only buffers like in `:InspectTree`
          local is_nofile = vim.bo[bufnr].buftype == "nofile"
          return is_nofile and "rainbow-blocks" or "rainbow-delimiters"
        end,
        clojure = "rainbow-delimiters",
        html = "rainbow-delimiters",
        lua = "rainbow-delimiters",
        go = "rainbow-delimiters",
        rust = "",
      },
    })
  end,
}

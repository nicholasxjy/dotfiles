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
  },
  config = function()
    require("rainbow-delimiters.setup").setup({
      query = {
        [""] = "",
        javascript = "rainbow-tags-react",
        tsx = "rainbow-tags-react",
        commonlisp = "rainbow-delimiters",
        scheme = "rainbow-delimiters",
        query = function(bufnr)
          -- Use blocks for read-only buffers like in `:InspectTree`
          local is_nofile = vim.bo[bufnr].buftype == "nofile"
          return is_nofile and "rainbow-blocks" or "rainbow-delimiters"
        end,
        clojure = "rainbow-delimiters",
        html = "rainbow-delimiters",
      },
    })
  end,
}

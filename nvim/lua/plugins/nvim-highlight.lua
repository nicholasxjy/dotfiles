return {
  "brenoprata10/nvim-highlight-colors",
  event = "VeryLazy",
  opts = {
    render = "virtual",
    virtual_symbol = "■",
    -- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
    exclude_filetypes = {},
    exclude_buftypes = {},
    -- Exclude buffer from highlighting e.g. 'exclude_buffer = function(bufnr) return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1000000 end'
    exclude_buffer = function(bufnr) end,
  },
}

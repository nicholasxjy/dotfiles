local fold_virt_text_handler = function(virt_text, lnum, end_lnum, width, truncate)
  local new_virt_text = {}
  local suffix = string.format(" +%s lines", end_lnum - lnum)
  local suffix_length = vim.fn.strdisplaywidth(suffix)
  local target_width = width - suffix_length
  local curr_width = 0
  for _, chunk in ipairs(virt_text) do
    local chunk_text = chunk[1]
    local chunk_length = vim.fn.strdisplaywidth(chunk_text)
    if target_width > curr_width + chunk_length then
      table.insert(new_virt_text, chunk)
    else
      chunk_text = truncate(chunk_text, target_width - curr_width)
      local hl_group = chunk[2]
      table.insert(new_virt_text, { chunk_text, hl_group })
      chunk_length = vim.fn.strdisplaywidth(chunk_text)
      if curr_width + chunk_length < target_width then
        suffix = suffix .. (" "):rep(target_width - curr_width - chunk_length)
      end
      break
    end
    curr_width = curr_width + chunk_length
  end
  table.insert(new_virt_text, { suffix, "MsgArea" })
  return new_virt_text
end

local function custom_selector(bufnr)
  local function handle_fallback_provider(err, providerName)
    if type(err) == "string" and err:match("UfoFallbackException") then
      return require("ufo").getFolds(bufnr, providerName)
    else
      return require("promise").reject(err)
    end
  end

  return require("ufo")
    .getFolds(bufnr, "lsp")
    :catch(function(err)
      return handle_fallback_provider(err, "treesitter")
    end)
    :catch(function(err)
      return handle_fallback_provider(err, "indent")
    end)
end

return {
  "kevinhwang91/nvim-ufo",
  event = { "InsertEnter", "BufRead", "BufNewFile" },
  dependencies = { "kevinhwang91/promise-async" },
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      desc = "Open all folds",
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      desc = "Close all folds",
    },
    {
      "zr",
      function()
        require("ufo").openFoldsExceptKinds()
      end,
      desc = "Fold less",
    },
    {
      "zm",
      function()
        require("ufo").closeFoldsWith()
      end,
      desc = "Fold more",
    },
    {
      "zp",
      function()
        require("ufo").peekFoldedLinesUnderCursor()
      end,
      desc = "Peek fold",
    },
  },
  opts = {
    provider_selector = function(_, _)
      return custom_selector
    end,
    close_fold_kinds_for_ft = {
      default = { "import", "import_statement" },
    },
    fold_virt_text_handler = fold_virt_text_handler,
    preview = {
      win_config = {
        winblend = 0,
      },
    },
  },
  config = function(_, opts)
    vim.o.foldcolumn = "1" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    require("ufo").setup(opts)
  end,
}

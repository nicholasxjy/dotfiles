local function handler(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  %d... "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

vim.pack.add({
  "https://github.com/kevinhwang91/promise-async",
  "https://github.com/kevinhwang91/nvim-ufo",
}, { load = false })

local loaded = false

local function load_ufo()
  if loaded then
    return require("ufo")
  end

  vim.cmd.packadd("promise-async")
  vim.cmd.packadd("nvim-ufo")

  local ufo = require("ufo")

  ufo.setup({
    preview = {
      mappings = {
        scrollB = "<C-B>",
        scrollF = "<C-F>",
        scrollU = "<C-U>",
        scrollD = "<C-D>",
      },
    },
    provider_selector = function(_, filetype, buftype)
      if filetype == "" or buftype == "nofile" then
        return "indent"
      end

      return { "treesitter", "indent" }
    end,
    fold_virt_text_handler = handler,
  })

  loaded = true

  return ufo
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  once = true,
  callback = function()
    load_ufo()
  end,
})

vim.keymap.set("n", "zR", function()
  load_ufo().openAllFolds()
end, { desc = "Open All Folds" })

vim.keymap.set("n", "zM", function()
  load_ufo().closeAllFolds()
end, { desc = "Close All Folds" })

vim.keymap.set("n", "zr", function()
  load_ufo().openFoldsExceptKinds()
end, { desc = "Open More Folds" })

vim.keymap.set("n", "zm", function()
  load_ufo().closeFoldsWith()
end, { desc = "Close More Folds" })

vim.keymap.set("n", "zp", function()
  load_ufo().peekFoldedLinesUnderCursor()
end, { desc = "Peek Fold" })

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

vim.keymap.set("n", "zR", function()
  ufo.openAllFolds()
end, { desc = "Open All Folds" })

vim.keymap.set("n", "zM", function()
  ufo.closeAllFolds()
end, { desc = "Close All Folds" })

vim.keymap.set("n", "zr", function()
  ufo.openFoldsExceptKinds()
end, { desc = "Open More Folds" })

vim.keymap.set("n", "zm", function()
  ufo.closeFoldsWith()
end, { desc = "Close More Folds" })

vim.keymap.set("n", "zp", function()
  ufo.peekFoldedLinesUnderCursor()
end, { desc = "Peek Fold" })

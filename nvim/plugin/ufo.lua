local util = require("util")

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

local function setup_ufo()
  if vim.g.ufo_setup_done then
    return require("ufo")
  end
  vim.g.ufo_setup_done = true

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
      local function handleFallbackException(bufnr, err, providerName)
        if type(err) == "string" and err:match("UfoFallbackException") then
          return require("ufo").getFolds(bufnr, providerName)
        else
          return require("promise").reject(err)
        end
      end

      return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
        or function(bufnr)
          return require("ufo")
            .getFolds(bufnr, "lsp")
            :catch(function(err)
              return handleFallbackException(bufnr, err, "treesitter")
            end)
            :catch(function(err)
              return handleFallbackException(bufnr, err, "indent")
            end)
        end
    end,
    fold_virt_text_handler = handler,
  })

  return ufo
end

util.later(setup_ufo, 20, "VimEnter", true)

vim.keymap.set("n", "zR", function()
  setup_ufo().openAllFolds()
end, { desc = "Open All Folds" })

vim.keymap.set("n", "zM", function()
  setup_ufo().closeAllFolds()
end, { desc = "Close All Folds" })

vim.keymap.set("n", "zr", function()
  setup_ufo().openFoldsExceptKinds()
end, { desc = "Open More Folds" })

vim.keymap.set("n", "zm", function()
  setup_ufo().closeFoldsWith()
end, { desc = "Close More Folds" })

vim.keymap.set("n", "zp", function()
  setup_ufo().peekFoldedLinesUnderCursor()
end, { desc = "Peek Fold" })

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "wolf359"
vim.opt.background = "dark"

local c = {
  bg0 = "#07070B",
  bg1 = "#0B0B13",
  bg2 = "#111119",
  bg3 = "#181825",
  bg4 = "#1E1E2D",
  bg5 = "#2A2A40",
  bg_sel = "#162030",

  fg0 = "#DDD5C0",
  fg1 = "#B8AE98",
  fg2 = "#887E72",
  fg3 = "#5A5450",

  orange = "#E86820",
  orange2 = "#C86418",
  orange3 = "#A04A18",

  blue = "#3A98F0",
  blue2 = "#2A82D8",
  blue3 = "#2468A8",

  cyan = "#00C8D8",
  cyan2 = "#00A0B0",
  cyan3 = "#007888",

  gold = "#C8A020",
  gold2 = "#B89020",

  moss = "#60A880",
  moss2 = "#50906A",

  teal = "#00BCA0",
  teal2 = "#008A74",

  red = "#E04840",
  red2 = "#FF4040",

  green = "#28A050",

  copper = "#D06048",
  copper2 = "#882C20",

  steel = "#708EAC",
  steel2 = "#586A84",
  gutter = "#2B3444",
  fold = "#3F4F61",
  hint = "#2C3544",

  pale = "#90B8D8",

  purple = "#B66CFF",

  pink = "#FE81D4",

  string = "#A8B86A",
  module = "#6686A0",
  doc = "#6F92A4",
  function_call = "#D0A028",
  method_call = "#E0B238",
  stdlib = "#68A880",
  vtext_bg = "#131A24",

  none = "NONE",
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ════════════════════════════════════════════════════════════
--  EDITOR BASE
-- ════════════════════════════════════════════════════════════
hi("Normal", { fg = c.fg0, bg = c.bg1 })
hi("NormalNC", { fg = c.fg1, bg = c.bg0 })
hi("NormalFloat", { fg = c.fg0, bg = c.bg1 })
hi("FloatBorder", { fg = c.blue3, bg = c.bg1 })

hi("FloatTitle", { fg = c.orange, bg = c.bg2, bold = true })
hi("FloatFooter", { fg = c.steel2, bg = c.bg2 })

hi("Cursor", { fg = c.bg1, bg = c.orange })
hi("CursorIM", { fg = c.bg1, bg = c.cyan })
hi("CursorLine", { bg = c.bg4 })
hi("CursorColumn", { bg = c.bg4 })
hi("CursorLineNr", { fg = c.orange, bg = c.bg4, bold = true })
hi("LineNr", { fg = c.gutter, bg = c.bg1 })
hi("SignColumn", { bg = c.bg1 })
hi("ColorColumn", { bg = c.bg4 })
hi("FoldColumn", { fg = c.gutter, bg = c.bg1 })
hi("Folded", { fg = c.fold, bg = c.bg3, italic = true })

hi("Visual", { bg = c.bg_sel })
hi("VisualNOS", { bg = c.bg3 })

hi("Search", { fg = c.bg1, bg = c.gold2, bold = true })
hi("CurSearch", { fg = c.bg1, bg = c.orange, bold = true })
hi("IncSearch", { fg = c.bg1, bg = c.gold, bold = true })
hi("Substitute", { fg = c.bg1, bg = c.copper })

hi("StatusLine", { fg = c.fg1, bg = c.bg4 })
hi("StatusLineNC", { fg = c.fg3, bg = c.bg3 })
hi("WinBar", { fg = c.fg1, bg = c.bg1 })
hi("WinBarNC", { fg = c.fg3, bg = c.bg0 })
hi("WinSeparator", { fg = c.bg5 })
hi("VertSplit", { fg = c.bg5 })

hi("TabLine", { fg = c.fg2, bg = c.bg4 })
hi("TabLineSel", { fg = c.orange, bg = c.bg2, bold = true })
hi("TabLineFill", { bg = c.bg0 })

hi("Pmenu", { fg = c.fg0, bg = c.bg3 })
hi("PmenuSel", { fg = c.fg0, bg = c.bg_sel, bold = true })
hi("PmenuSbar", { bg = c.bg4 })
hi("PmenuThumb", { bg = c.steel2 })
hi("PmenuKind", { fg = c.cyan, bg = c.bg3 })
hi("PmenuKindSel", { fg = c.cyan, bg = c.bg_sel })
hi("PmenuExtra", { fg = c.fg2, bg = c.bg3 })

hi("MatchParen", { fg = c.bg1, bg = c.orange2, bold = true })
hi("NonText", { fg = c.bg5 })
hi("SpecialKey", { fg = c.steel2 })
hi("Whitespace", { fg = c.bg5 })
hi("EndOfBuffer", { fg = c.bg3 })
hi("Conceal", { fg = c.steel2 })
hi("QuickFixLine", { bg = c.bg_sel })

hi("Directory", { fg = c.blue, bold = true })
hi("Title", { fg = c.orange, bold = true })
hi("Question", { fg = c.cyan })
hi("MoreMsg", { fg = c.gold })
hi("ModeMsg", { fg = c.fg0, bold = true })
hi("ErrorMsg", { fg = c.red2, bold = true })
hi("WarningMsg", { fg = c.gold })

hi("SpellBad", { undercurl = true, sp = c.red })
hi("SpellCap", { undercurl = true, sp = c.blue })
hi("SpellRare", { undercurl = true, sp = c.cyan })
hi("SpellLocal", { undercurl = true, sp = c.gold })

hi("NonText", { fg = c.fg3 })

-- ════════════════════════════════════════════════════════════
--  DIFF
-- ════════════════════════════════════════════════════════════
hi("DiffAdd", { fg = c.green, bg = "#1C1A10" })
hi("DiffChange", { fg = c.gold, bg = "#1A1408" })
hi("DiffDelete", { fg = c.red, bg = "#1A0808" })
hi("DiffText", { fg = c.fg0, bg = "#281E08", bold = true })
hi("Added", { fg = c.green })
hi("Changed", { fg = c.gold })
hi("Removed", { fg = c.red })

-- ════════════════════════════════════════════════════════════
--  SYNTAX BASE (fallback without treesitter)
-- ════════════════════════════════════════════════════════════
hi("Comment", { fg = c.fg2, italic = true })
hi("Todo", { fg = c.bg1, bg = c.gold, bold = true })
hi("Error", { fg = c.red2, bold = true })
hi("Underlined", { underline = true })
hi("Bold", { bold = true })
hi("Italic", { italic = true })

hi("Keyword", { fg = c.orange, bold = true })
hi("Statement", { fg = c.orange, bold = true })
hi("Conditional", { fg = c.orange, bold = true })
hi("Repeat", { fg = c.orange, bold = true })
hi("Label", { fg = c.orange })
hi("Exception", { fg = c.orange, bold = true })
hi("StorageClass", { fg = c.orange })
hi("Structure", { fg = c.blue, bold = true })
hi("Typedef", { fg = c.blue })

hi("Identifier", { fg = c.fg0 })
hi("Function", { fg = c.gold, bold = true })
hi("Operator", { fg = c.steel })
hi("Type", { fg = c.blue })

hi("String", { fg = c.string })
hi("Character", { fg = c.string })
hi("Number", { fg = c.teal })
hi("Float", { fg = c.teal })
hi("Boolean", { fg = c.orange })
hi("Constant", { fg = c.pale })

hi("Special", { fg = c.copper })
hi("SpecialChar", { fg = c.copper })
hi("Tag", { fg = c.blue })
hi("Delimiter", { fg = c.fg2 })
hi("SpecialComment", { fg = c.cyan2, italic = true })
hi("Debug", { fg = c.red })

hi("PreProc", { fg = c.orange2 })
hi("Include", { fg = c.orange })
hi("Define", { fg = c.orange })
hi("Macro", { fg = c.copper, bold = true })
hi("PreCondit", { fg = c.orange })

-- ════════════════════════════════════════════════════════════
--  TREESITTER
-- ════════════════════════════════════════════════════════════
hi("@tag", { fg = c.blue, bold = true })
hi("@tag.tsx", { fg = c.blue, bold = true })
hi("@tag.attribute", { fg = c.pale })
hi("@tag.delimiter", { fg = c.steel })
hi("@variable", { fg = c.fg0 })
hi("@variable.builtin", { fg = c.orange, italic = true }) -- self, super
hi("@variable.parameter", { fg = c.fg1 })
hi("@variable.member", { fg = c.steel })

hi("@constant", { fg = c.pale })
hi("@constant.builtin", { fg = c.orange })
hi("@constant.macro", { fg = c.pale })

hi("@string", { fg = c.string })
hi("@string.escape", { fg = c.copper })
hi("@string.special", { fg = c.copper })
hi("@string.regexp", { fg = c.copper })
hi("@character", { fg = c.string })
hi("@character.special", { fg = c.copper })

hi("@number", { fg = c.teal })
hi("@number.float", { fg = c.teal })
hi("@boolean", { fg = c.orange })

hi("@type", { fg = c.blue })
hi("@type.builtin", { fg = c.moss }) -- i32, bool, str, usize
hi("@type.definition", { fg = c.blue, bold = true })
hi("@type.qualifier", { fg = c.orange }) -- pub, mut, ref
hi("@type.interface", { fg = c.cyan, bold = true }) -- traits in #[derive(...)]

hi("@function", { fg = c.gold, bold = true })
hi("@function.builtin", { fg = c.gold })
hi("@function.call", { fg = c.function_call })
hi("@function.method", { fg = c.gold, bold = true })
hi("@function.method.call", { fg = c.method_call })
hi("@function.macro", { fg = c.copper, bold = true }) -- println!, vec!, panic!
hi("@constructor", { fg = c.blue, bold = true }) -- MyStruct { .. }

hi("@keyword", { fg = c.orange, bold = true })
hi("@keyword.function", { fg = c.orange, bold = true }) -- fn
hi("@keyword.operator", { fg = c.steel }) -- as, in
hi("@keyword.import", { fg = c.teal }) -- use
hi("@keyword.export", { fg = c.teal }) -- use
hi("@keyword.type", { fg = c.orange }) -- type, struct, enum, trait
hi("@keyword.modifier", { fg = c.orange }) -- pub, mut, unsafe, extern
hi("@keyword.repeat", { fg = c.orange, bold = true }) -- for, while, loop
hi("@keyword.return", { fg = c.orange, bold = true }) -- return
hi("@keyword.exception", { fg = c.orange, bold = true }) -- ?
hi("@keyword.conditional", { fg = c.orange, bold = true }) -- if, else, match
hi("@keyword.directive", { fg = c.orange2 })
hi("@keyword.coroutine", { fg = c.orange, bold = true }) -- async, await

hi("@operator", { fg = c.steel })
hi("@punctuation.bracket", { fg = c.steel })
hi("@punctuation.delimiter", { fg = c.fg2 })
hi("@punctuation.special", { fg = c.copper })

hi("@comment", { fg = c.fg2, italic = true })
hi("@comment.documentation", { fg = c.doc, italic = true })
hi("@comment.todo", { fg = c.bg1, bg = c.gold, bold = true })
hi("@comment.error", { fg = c.bg1, bg = c.red, bold = true })
hi("@comment.warning", { fg = c.bg1, bg = c.gold2, bold = true })
hi("@comment.note", { fg = c.bg1, bg = c.cyan2, bold = true })

hi("@module", { fg = c.module })
hi("@module.builtin", { fg = c.module })
hi("@namespace", { fg = c.module })

hi("@attribute", { fg = c.purple })
hi("@attribute.builtin", { fg = c.purple })

hi("@label", { fg = c.copper, italic = true })

hi("@markup.heading", { fg = c.orange, bold = true })
hi("@markup.link", { fg = c.blue, underline = true })
hi("@markup.raw", { fg = c.string })
hi("@markup.strong", { bold = true })
hi("@markup.italic", { italic = true })
hi("@markup.list", { fg = c.steel })

-- ════════════════════════════════════════════════════════════
--  LSP SEMANTIC TOKENS (rust-analyzer)
-- ════════════════════════════════════════════════════════════
hi("@lsp.type.keyword", { link = "@keyword" })
hi("@lsp.type.function", { fg = c.gold, bold = true })
hi("@lsp.type.method", { fg = c.method_call })
hi("@lsp.type.type", { link = "@type" })
hi("@lsp.type.class", { fg = c.blue, bold = true })
hi("@lsp.type.struct", { fg = c.blue })
hi("@lsp.type.enum", { fg = c.blue })
hi("@lsp.type.enumMember", { fg = c.cyan })
hi("@lsp.type.interface", { fg = c.cyan, bold = true }) -- traits
hi("@lsp.type.typeParameter", { fg = c.pale, italic = true }) -- <T>, <U>
hi("@lsp.type.property", { fg = c.pale })
hi("@lsp.type.field", { fg = c.fg1 })
hi("@lsp.type.variable", { link = "@variable" })
hi("@lsp.type.parameter", { fg = c.fg1 })
hi("@lsp.type.macro", { fg = c.copper, bold = true })
hi("@lsp.type.lifetime", { fg = c.copper, bold = true, italic = true }) -- 'a, 'static
hi("@lsp.type.operator", { link = "@operator" })
hi("@lsp.type.comment", { link = "@comment" })
hi("@lsp.type.string", { link = "@string" })
hi("@lsp.type.number", { link = "@number" })
hi("@lsp.type.boolean", { link = "@boolean" })
hi("@lsp.type.selfKeyword", { fg = c.orange, italic = true }) -- self
hi("@lsp.type.selfTypeKeyword", { fg = c.blue, bold = true }) -- Self
hi("@lsp.type.formatSpecifier", { fg = c.copper }) -- {} in format strings
hi("@lsp.type.attribute", { fg = c.purple })
hi("@lsp.type.namespace", { link = "@module" })
hi("@lsp.type.builtinType", { fg = c.moss })
hi("@lsp.type.generic", { fg = c.pale })
hi("@lsp.type.decorator", { fg = c.purple })

hi("@lsp.typemod.function.async", { fg = c.gold, italic = true })
hi("@lsp.typemod.method.async", { fg = c.function_call, italic = true })
hi("@lsp.typemod.variable.global", { fg = c.copper, bold = true })
-- hi("@lsp.typemod.variable.mutable", { underline = true })
-- hi("@lsp.typemod.parameter.mutable", { underline = true })
hi("@lsp.typemod.variable.static", { fg = c.pale })
hi("@lsp.typemod.variable.constant", { fg = c.pale })
hi("@lsp.typemod.function.unsafe", { fg = c.red, bold = true })
hi("@lsp.typemod.method.unsafe", { fg = c.red, bold = true })
hi("@lsp.typemod.keyword.unsafe", { fg = c.red2, bold = true })
hi("@lsp.typemod.struct.public", { fg = c.blue })
hi("@lsp.typemod.enum.public", { fg = c.blue })
hi("@lsp.typemod.struct.defaultLibrary", { fg = c.stdlib }) -- String, Vec, HashMap
hi("@lsp.typemod.function.public", { fg = c.gold, bold = true })
hi("@lsp.typemod.parameter.intraDocLink", { fg = c.blue, underline = true })
hi("@lsp.mod.reference", { underline = true, sp = c.steel })

-- ════════════════════════════════════════════════════════════
--  DIAGNOSTICS
-- ════════════════════════════════════════════════════════════
hi("DiagnosticError", { fg = c.red2 })
hi("DiagnosticWarn", { fg = c.gold })
hi("DiagnosticInfo", { fg = c.blue })
hi("DiagnosticHint", { fg = c.cyan })
hi("DiagnosticOk", { fg = c.green })

hi("DiagnosticSignError", { fg = c.red2, bg = c.bg1 })
hi("DiagnosticSignWarn", { fg = c.gold, bg = c.bg1 })
hi("DiagnosticSignInfo", { fg = c.blue, bg = c.bg1 })
hi("DiagnosticSignHint", { fg = c.cyan, bg = c.bg1 })

hi("DiagnosticUnderlineError", { undercurl = true, sp = c.red2 })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.gold })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = c.cyan })

hi("DiagnosticVirtualTextError", { fg = c.red2, bg = c.vtext_bg, italic = true })
hi("DiagnosticVirtualTextWarn", { fg = c.gold, bg = c.vtext_bg, italic = true })
hi("DiagnosticVirtualTextInfo", { fg = c.blue, bg = c.vtext_bg, italic = true })
hi("DiagnosticVirtualTextHint", { fg = c.cyan2, bg = c.vtext_bg, italic = true })
hi("DiagnosticVirtualTextNoText", { fg = c.cyan2, bg = c.vtext_bg, italic = true })

hi("DiagnosticFloatingError", { fg = c.red2 })
hi("DiagnosticFloatingWarn", { fg = c.gold })
hi("DiagnosticFloatingInfo", { fg = c.blue })
hi("DiagnosticFloatingHint", { fg = c.cyan })

-- ════════════════════════════════════════════════════════════
--  LSP
-- ════════════════════════════════════════════════════════════
hi("LspReferenceText", { bg = c.bg3 })
hi("LspReferenceRead", { bg = c.bg3 })
hi("LspReferenceWrite", { bg = c.bg3, bold = true })
hi("LspInlayHint", { fg = c.hint, bg = c.bg2, italic = true })
hi("LspCodeLens", { fg = c.steel2, italic = true })
hi("LspSignatureActiveParameter", { fg = c.gold, bold = true, underline = true })

-- ════════════════════════════════════════════════════════════
--  TELESCOPE
-- ════════════════════════════════════════════════════════════
hi("TelescopeNormal", { fg = c.fg0, bg = c.bg2 })
hi("TelescopeBorder", { fg = c.blue3, bg = c.bg2 })
hi("TelescopeTitle", { fg = c.orange, bg = c.bg2, bold = true })
hi("TelescopePromptNormal", { fg = c.fg0, bg = c.bg3 })
hi("TelescopePromptBorder", { fg = c.orange2, bg = c.bg3 })
hi("TelescopePromptTitle", { fg = c.bg1, bg = c.orange, bold = true })
hi("TelescopeResultsNormal", { fg = c.fg0, bg = c.bg2 })
hi("TelescopePreviewNormal", { fg = c.fg0, bg = c.bg1 })
hi("TelescopePreviewBorder", { fg = c.blue3, bg = c.bg1 })
hi("TelescopePreviewTitle", { fg = c.bg1, bg = c.blue2, bold = true })
hi("TelescopeMatching", { fg = c.gold, bold = true })
hi("TelescopeSelection", { bg = c.bg_sel, bold = true })
hi("TelescopeSelectionCaret", { fg = c.orange, bg = c.bg_sel })

-- ════════════════════════════════════════════════════════════
--  NVIM-CMP
-- ════════════════════════════════════════════════════════════
hi("CmpItemAbbr", { fg = c.fg0 })
hi("CmpItemAbbrDeprecated", { fg = c.fg3, strikethrough = true })
hi("CmpItemAbbrMatch", { fg = c.gold, bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = c.gold })
hi("CmpItemMenu", { fg = c.fg2 })
hi("CmpItemKindFunction", { fg = c.gold })
hi("CmpItemKindMethod", { fg = c.gold })
hi("CmpItemKindConstructor", { fg = c.blue })
hi("CmpItemKindField", { fg = c.fg0 })
hi("CmpItemKindVariable", { fg = c.fg0 })
hi("CmpItemKindClass", { fg = c.blue })
hi("CmpItemKindInterface", { fg = c.cyan })
hi("CmpItemKindModule", { fg = c.module })
hi("CmpItemKindKeyword", { fg = c.orange })
hi("CmpItemKindSnippet", { fg = c.copper })
hi("CmpItemKindValue", { fg = c.string })
hi("CmpItemKindEnum", { fg = c.blue })
hi("CmpItemKindEnumMember", { fg = c.cyan })
hi("CmpItemKindConstant", { fg = c.pale })
hi("CmpItemKindStruct", { fg = c.blue })
hi("CmpItemKindType", { fg = c.blue })
hi("CmpItemKindOperator", { fg = c.steel })
hi("CmpItemKindTypeParameter", { fg = c.pale })

-- ════════════════════════════════════════════════════════════
--  GITSIGNS
-- ════════════════════════════════════════════════════════════
hi("GitSignsAdd", { fg = c.green })
hi("GitSignsChange", { fg = c.gold2 })
hi("GitSignsDelete", { fg = c.red })
hi("GitSignsTopdelete", { fg = c.red })
hi("GitSignsChangedelete", { fg = c.copper })
hi("GitSignsUntracked", { fg = c.steel2 })

-- ════════════════════════════════════════════════════════════
--  WHICH-KEY
-- ════════════════════════════════════════════════════════════
hi("WhichKey", { fg = c.cyan })
hi("WhichKeyGroup", { fg = c.orange })
hi("WhichKeyDesc", { fg = c.fg1 })
hi("WhichKeySeparator", { fg = c.steel2 })
hi("WhichKeyValue", { fg = c.gold })
hi("WhichKeyBorder", { fg = c.blue3 })
hi("WhichKeyNormal", { bg = c.bg2 })

-- ════════════════════════════════════════════════════════════
--  NEO-TREE
-- ════════════════════════════════════════════════════════════
hi("NeoTreeNormal", { fg = c.fg0, bg = c.bg0 })
hi("NeoTreeNormalNC", { fg = c.fg1, bg = c.bg0 })
hi("NeoTreeDirectoryName", { fg = c.blue })
hi("NeoTreeDirectoryIcon", { fg = c.blue2 })
hi("NeoTreeFileName", { fg = c.fg0 })
hi("NeoTreeGitAdded", { fg = c.green })
hi("NeoTreeGitModified", { fg = c.gold2 })
hi("NeoTreeGitDeleted", { fg = c.red })
hi("NeoTreeGitConflict", { fg = c.red, bold = true })
hi("NeoTreeGitUntracked", { fg = c.steel })

-- ════════════════════════════════════════════════════════════
--  INDENT-BLANKLINE
-- ════════════════════════════════════════════════════════════
hi("IblIndent", { fg = "#181828" })
hi("IblScope", { fg = "#242438" })

-- ════════════════════════════════════════════════════════════
--  MINI STATUS
-- ════════════════════════════════════════════════════════════
hi("MiniStatuslineModeNormal", { fg = c.bg1, bg = c.blue, bold = true })
hi("MiniStatuslineModeInsert", { fg = c.bg1, bg = c.orange, bold = true })
hi("MiniStatuslineModeVisual", { fg = c.bg1, bg = c.cyan, bold = true })
hi("MiniStatuslineModeReplace", { fg = c.bg1, bg = c.red, bold = true })
hi("MiniStatuslineModeCommand", { fg = c.bg1, bg = c.gold, bold = true })
hi("MiniStatuslineDevinfo", { fg = c.fg1, bg = c.bg4 })
hi("MiniStatuslineFilename", { fg = c.fg0, bg = c.bg3 })
hi("MiniStatuslineFileinfo", { fg = c.fg1, bg = c.bg4 })
hi("MiniStatuslineInactive", { fg = c.fg3, bg = c.bg3 })

-- ════════════════════════════════════════════════════════════
--  RAINBOW DELIMITERS
-- ════════════════════════════════════════════════════════════
hi("RainbowDelimiterRed", { fg = c.red2, bg = nil })
hi("RainbowDelimiterCyan", { fg = c.cyan, bg = nil })
hi("RainbowDelimiterYellow", { fg = c.gold2, bg = nil })
hi("RainbowDelimiterGreen", { fg = c.green, bg = nil })
hi("RainbowDelimiterOrange", { fg = c.orange2, bg = nil })
hi("RainbowDelimiterViolet", { fg = c.purple, bg = nil })
hi("RainbowDelimiterBlue", { fg = c.blue2, bg = nil })

hi("BlinkPairsBlue", { fg = c.blue2, bg = nil })
hi("BlinkPairsCyan", { fg = c.cyan, bg = nil })
hi("BlinkPairsGreen", { fg = c.green, bg = nil })
hi("BlinkPairsOrange", { fg = c.orange2, bg = nil })
hi("BlinkPairsRed", { fg = c.red2, bg = nil })
hi("BlinkPairsViolet", { fg = c.purple, bg = nil })
hi("BlinkPairsYellow", { fg = c.gold2, bg = nil })

hi("BlinkIndentBlue", { fg = c.blue2, bg = nil })
hi("BlinkIndentCyan", { fg = c.cyan, bg = nil })
hi("BlinkIndentGreen", { fg = c.green, bg = nil })
hi("BlinkIndentOrange", { fg = c.orange2, bg = nil })
hi("BlinkIndentRed", { fg = c.red2, bg = nil })
hi("BlinkIndentViolet", { fg = c.purple, bg = nil })
hi("BlinkIndentYellow", { fg = c.gold2, bg = nil })

hi("BlinkIndentBlueUnderline", { fg = c.blue2, bg = nil })
hi("BlinkIndentCyanUnderline", { fg = c.cyan, bg = nil })
hi("BlinkIndentGreenUnderline", { fg = c.green, bg = nil })
hi("BlinkIndentOrangeUnderline", { fg = c.orange2, bg = nil })
hi("BlinkIndentRedUnderline", { fg = c.red2, bg = nil })
hi("BlinkIndentVioletUnderline", { fg = c.purple, bg = nil })
hi("BlinkIndentYellowUnderline", { fg = c.gold2, bg = nil })

hi("SnacksPickerDir", { fg = c.steel2, bg = c.bg0 })
hi("SnacksPickerMatch", { fg = c.copper, bg = c.bg3, bold = true })
hi("SnacksPickerPreviewBorder", { fg = c.green, bg = c.bg1 })
hi("SnacksPickerListBorder", { fg = c.gold, bg = c.bg1 })
hi("SnacksPickerBoxBorder", { fg = c.blue, bg = c.bg1 })
hi("SnacksPickerInputBorder", { fg = c.cyan, bg = c.bg1 })
hi("SnacksPickerInput", { fg = c.pink, bg = c.bg1, bold = true })
hi("SnacksPickerPreview", { bg = c.bg1 })
hi("SnacksPickerList", { bg = c.bg1 })
hi("SnacksPickerBox", { bg = c.bg1 })

hi("BlinkCmpMenu", { link = "NormalFloat" })
hi("BlinkCmpMenuBorder", { fg = c.gold, bg = c.bg1 })
hi("BlinkCmpDocBorder", { fg = c.green, bg = c.bg1 })
hi("BlinkCmpSignatureHelpBorder", { fg = c.red, bg = c.bg1 })
hi("BlinkCmpLabelDeprecated", { fg = c.fg3, strikethrough = true })

hi("BlinkCmpKindClass", { link = "Type" })
hi("BlinkCmpKindColor", { link = "Special" })
hi("BlinkCmpKindConstant", { link = "Constant" })
hi("BlinkCmpKindConstructor", { link = "Type" })
hi("BlinkCmpKindEnum", { link = "Structure" })
hi("BlinkCmpKindEnumMember", { link = "Structure" })
hi("BlinkCmpKindEvent", { link = "Exception" })
hi("BlinkCmpKindField", { link = "Structure" })
hi("BlinkCmpKindFile", { link = "Tag" })
hi("BlinkCmpKindFolder", { link = "Directory" })
hi("BlinkCmpKindFunction", { link = "Function" })
hi("BlinkCmpKindInterface", { link = "Structure" })
hi("BlinkCmpKindKeyword", { link = "Keyword" })
hi("BlinkCmpKindMethod", { link = "Function" })
hi("BlinkCmpKindModule", { link = "Structure" })
hi("BlinkCmpKindOperator", { link = "Operator" })
hi("BlinkCmpKindProperty", { link = "Structure" })
hi("BlinkCmpKindReference", { link = "Tag" })
hi("BlinkCmpKindSnippet", { link = "Special" })
hi("BlinkCmpKindStruct", { link = "Structure" })
hi("BlinkCmpKindText", { link = "Normal" })
hi("BlinkCmpKindTypeParameter", { link = "Type" })
hi("BlinkCmpKindUnit", { link = "Special" })
hi("BlinkCmpKindValue", { link = "Identifier" })
hi("BlinkCmpKindVariable", { link = "Identifier" })

hi("MiniSurround", { link = "IncSearch" })

hi("MiniTablineCurrent", { fg = c.gold2, bg = c.bg1, bold = true })
hi("MiniTablineFill", { link = "MiniTablineHidden" })
hi("MiniTablineHidden", { fg = c.fg2, bg = c.bg0 })
hi("MiniTablineModifiedCurrent", { fg = c.bg1, bg = c.gold2, bold = true })
hi("MiniTablineModifiedHidden", { fg = c.bg0, bg = c.fg2 })
hi("MiniTablineModifiedVisible", { fg = c.bg0, bg = c.fg2, bold = true })
hi("MiniTablineTabpagesection", { fg = c.bg1, bg = c.green, bold = true })
hi("MiniTablineTrunc", { fg = c.gold2, bg = c.bg0, bold = true })
hi("MiniTablineVisible", { fg = c.fg2, bg = c.bg0, bold = true })

hi("MiniClueBorder", { link = "FloatBorder" })
hi("MiniClueDescGroup", { link = "DiagnosticFloatingWarn" })
hi("MiniClueDescSingle", { link = "NormalFloat" })
hi("MiniClueNextKey", { link = "DiagnosticFloatingHint" })
hi("MiniClueNextKeyWithPostkeys", { link = "DiagnosticFloatingError" })
hi("MiniClueSeparator", { link = "DiagnosticFloatingInfo" })
hi("MiniClueTitle", { link = "FloatTitle" })

hi("MiniFilesBorder", { link = "FloatBorder" })
hi("MiniFilesBorderModified", { link = "DiagnosticFloatingWarn" })
hi("MiniFilesCursorLine", { link = "CursorLine" })
hi("MiniFilesDirectory", { link = "Directory" })
hi("MiniFilesFile", { fg = c.fg, bg = nil })
hi("MiniFilesNormal", { link = "NormalFloat" })
hi("MiniFilesTitle", { link = "FloatTitle" })
hi("MiniFilesTitleFocused", { fg = c.fg, bg = c.bg0, bold = true })
hi("MiniIconsAzure", { fg = c.teal, bg = nil })
hi("MiniIconsBlue", { fg = c.blue, bg = nil })
hi("MiniIconsCyan", { fg = c.cyan, bg = nil })
hi("MiniIconsGreen", { fg = c.green, bg = nil })
hi("MiniIconsGrey", { fg = c.fg1, bg = nil })
hi("MiniIconsOrange", { fg = c.orange, bg = nil })
hi("MiniIconsPurple", { fg = c.purple, bg = nil })
hi("MiniIconsRed", { fg = c.red, bg = nil })
hi("MiniIconsYellow", { fg = c.gold, bg = nil })

hi("MiniNotifyBorder", { link = "FloatBorder" })
hi("MiniNotifyLspProgress", { link = "MiniNotifyNormal" })
hi("MiniNotifyNormal", { link = "NormalFloat" })
hi("MiniNotifyTitle", { link = "FloatTitle" })

hi("MiniStatuslineDevinfo", { fg = c.fg1, bg = c.bg0 })
hi("MiniStatuslineFileinfo", { link = "MiniStatuslineDevinfo" })
hi("MiniStatuslineFilename", { fg = c.fg1, bg = c.bg0 })
hi("MiniStatuslineInactive", { link = "StatusLineNC" })
hi("MiniStatuslineModeCommand", { fg = c.bg1, bg = c.gold, bold = true })
hi("MiniStatuslineModeInsert", { fg = c.bg1, bg = c.teal, bold = true })
hi("MiniStatuslineModeNormal", { fg = c.bg1, bg = c.fg, bold = true })
hi("MiniStatuslineModeOther", { fg = c.bg1, bg = c.cyan, bold = true })
hi("MiniStatuslineModeReplace", { fg = c.bg1, bg = c.red, bold = true })
hi("MiniStatuslineModeVisual", { fg = c.bg1, bg = c.green, bold = true })
-- ════════════════════════════════════════════════════════════
--  NEOVIM 0.12+ — filetype-suffixed LSP groups
--
--  Neovim 0.12 applies:
--    @lsp.type.{type}.rust          priority +0
--    @lsp.mod.{mod}.rust            priority +1
--    @lsp.typemod.{type}.{mod}.rust priority +2
--
--  If a .rust-suffixed group is undefined, Neovim creates an
--  empty group that silently overrides treesitter. Every type
--  and typemod must be explicitly linked to its unsuffixed base.
-- ════════════════════════════════════════════════════════════

local lsp_types = {
  "function",
  "method",
  "type",
  "class",
  "struct",
  "enum",
  "enumMember",
  "interface",
  "typeParameter",
  "property",
  "field",
  "variable",
  "parameter",
  "macro",
  "lifetime",
  "keyword",
  "comment",
  "string",
  "number",
  "boolean",
  "selfKeyword",
  "selfTypeKeyword",
  "formatSpecifier",
  "attribute",
  "decorator",
  "namespace",
  "builtinType",
  "generic",
}

local lsp_modifiers = {
  "declaration",
  "definition",
  "static",
  "abstract",
  "deprecated",
  "readonly",
  "defaultLibrary",
  "async",
  "attribute",
  "callable",
  "constant",
  "consuming",
  "controlFlow",
  "crateRoot",
  "injected",
  "library",
  "macro",
  "mutable",
  "public",
  "reference",
  "trait",
  "unsafe",
  "documentation",
  "intraDocLink",
  "derive",
}

for _, t in ipairs(lsp_types) do
  hi("@lsp.type." .. t .. ".rust", { link = "@lsp.type." .. t })
end

-- For each type × modifier: if no explicit typemod group exists, fall back to
-- the base type so that e.g. function.declaration doesn't render as Normal.
for _, t in ipairs(lsp_types) do
  local base = "@lsp.type." .. t
  for _, m in ipairs(lsp_modifiers) do
    local typemod = "@lsp.typemod." .. t .. "." .. m
    local existing = vim.api.nvim_get_hl(0, { name = typemod, link = false })
    if not next(existing) then
      hi(typemod, { link = base })
    end
    hi(typemod .. ".rust", { link = typemod })
  end
end

for _, m in ipairs(lsp_modifiers) do
  hi("@lsp.mod." .. m .. ".rust", { link = "@lsp.mod." .. m })
end

-- ════════════════════════════════════════════════════════════
--  RUNTIME AUTOCMDS
--
--  Two issues require runtime fixes:
--  1. String/Vec/HashMap get both 'defaultLibrary' and 'public'
--     modifiers from rust-analyzer. Both create extmarks at the
--     same priority (+2); 'public' (blue) tends to win. Fix:
--     re-apply the correct group at priority +10 via LspTokenUpdate.
--  2. Traits inside #[derive(...)] get no LSP tokens at all.
--     Fix: parse the tree directly and apply extmarks at priority 200.
-- ════════════════════════════════════════════════════════════
do
  local aug = vim.api.nvim_create_augroup("wolf359", { clear = true })
  local derive_ns = vim.api.nvim_create_namespace("wolf359_derive")
  local _dq

  local function hl_derive_traits(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end
    local ok_p, parser = pcall(vim.treesitter.get_parser, bufnr, "rust")
    if not ok_p or not parser then
      return
    end
    local trees = parser:parse()
    if not (trees and trees[1]) then
      return
    end

    if not _dq then
      local ok_q, q = pcall(
        vim.treesitter.query.parse,
        "rust",
        [[
        (attribute_item
          (attribute
            (identifier) @_name
            arguments: (token_tree
              (identifier) @trait))
          (#eq? @_name "derive"))
      ]]
      )
      if ok_q then
        _dq = q
      end
    end
    if not _dq then
      return
    end

    vim.api.nvim_buf_clear_namespace(bufnr, derive_ns, 0, -1)
    for id, node in _dq:iter_captures(trees[1]:root(), bufnr, 0, -1) do
      if _dq.captures[id] == "trait" then
        local r1, c1, r2, c2 = node:range()
        vim.api.nvim_buf_set_extmark(bufnr, derive_ns, r1, c1, {
          end_row = r2,
          end_col = c2,
          hl_group = "@lsp.type.interface",
          priority = 200,
        })
      end
    end
  end

  -- Clean up when another colorscheme loads
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = aug,
    callback = function(ev)
      if ev.match ~= "wolf359" then
        pcall(vim.api.nvim_del_augroup_by_name, "wolf359")
      end
    end,
  })

  -- Force correct color for stdlib structs and traits
  vim.api.nvim_create_autocmd("LspTokenUpdate", {
    group = aug,
    callback = function(args)
      local t = args.data.token
      local htok = vim.lsp.semantic_tokens.highlight_token
      local prio = vim.hl.priorities.semantic_tokens + 10
      if t.type == "struct" and t.modifiers.defaultLibrary then
        htok(t, args.buf, args.data.client_id, "@lsp.typemod.struct.defaultLibrary", { priority = prio })
      elseif t.type == "interface" then
        htok(t, args.buf, args.data.client_id, "@lsp.type.interface", { priority = prio })
      end
    end,
  })

  -- Highlight traits in #[derive(...)] via direct extmarks
  vim.api.nvim_create_autocmd({ "BufEnter", "BufRead", "BufWritePost" }, {
    group = aug,
    pattern = "*.rs",
    callback = function(ev)
      vim.schedule(function()
        hl_derive_traits(ev.buf)
      end)
    end,
  })

  -- Handle already-open buffers on colorscheme load
  vim.schedule(function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "rust" then
        pcall(vim.lsp.semantic_tokens.force_refresh, buf)
        hl_derive_traits(buf)
      end
    end
  end)
end

return c

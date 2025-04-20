return {
  "comfysage/cuddlefish.nvim",
  config = function()
    require("cuddlefish").setup({
      theme = {
        variant = "spring",
        accent = "pink",
      },
      editor = {
        transparent_background = true,
        sign = { color = "none" },
      },
      style = {
        tabline = { "reverse" },
        search = { "italic", "reverse" },
        incsearch = { "italic", "reverse" },
        types = { "bold" },
        keyword = { "italic", "bold" },
        comment = { "italic" },
      },
      integrations = {
        semantic_tokens = false,
      },
      overrides = function(colors)
        return {
          ["@tag"] = { style = { "bold" } },
          ["@tag.attribute"] = { style = { "italic" }, fg = "#5f7e97" },
          ["@keyword.import"] = { style = { "bold", "italic" }, fg = colors.snow },
          ["@keyword.export"] = { style = { "bold", "italic" }, fg = colors.snow },
          ["@keyword.coroutine"] = { style = { "bold", "italic" }, fg = colors.purple },
          ["@operator"] = { fg = "#86DCE9", style = { "bold" } },
          ["@keyword.modifier"] = { fg = "#029fff", style = { "bold", "italic" } },
          ["@function"] = { fg = colors.pink },
          ["@function.method"] = { fg = "#9D599D" },
          ["@constructor"] = { fg = "#0fb9e0", style = { "bold" } },

          ["@lsp.type.enum"] = { fg = "#507687", style = { "bold" } },
          ["@lsp.type.enumMember"] = { fg = "#A9907E" },
          ["@lsp.type.interface"] = { fg = "#9D5C0D", style = { "bold" } },

          ["@lsp.type.boolean"] = { link = "@boolean" },
          ["@lsp.type.builtinType"] = { link = "@type.builtin" },
          ["@lsp.type.comment"] = { link = "@comment" },
          ["@lsp.type.decorator"] = { link = "@attribute" },
          ["@lsp.type.deriveHelper"] = { link = "@attribute" },
          ["@lsp.type.class"] = { link = "@constructor" }, -- Identifiers that declare or reference a class type
          ["@lsp.type.function"] = { link = "@function" }, -- Identifiers that declare a function
          ["@lsp.type.method"] = { link = "@function.method" }, -- Identifiers that declare a member function or method
          ["@lsp.type.keyword"] = { link = "@keyword" }, -- Tokens that represent a language keyword
          ["@lsp.type.modifier"] = { link = "@keyword.modifier" }, -- Tokens that represent a modifier
          ["@lsp.type.namespace"] = { link = "@module" }, -- Identifiers that declare or reference a namespace, module, or package
          ["@lsp.type.number"] = { link = "@number" }, -- Tokens that represent a number literal
          ["@lsp.type.operator"] = { link = "@operator" }, -- Tokens that represent an operator
          ["@lsp.type.parameter"] = { link = "@variable.parameter" }, -- Identifiers that declare or reference a function or method parameters
          ["@lsp.type.property"] = { link = "@variable.member" }, -- Identifiers that declare or reference a member property, member field, or member variable
          ["@lsp.type.regexp"] = { link = "@string.regexp" }, -- Tokens that represent a regular expression literal
          ["@lsp.type.string"] = { link = "@string" }, -- Tokens that represent a string literal
          ["@lsp.type.type"] = { link = "@type" }, -- Identifiers that declare or reference a type that is not covered above
          ["@lsp.type.variable"] = { link = "@variable" }, -- Identifiers that declare or reference a local or global variable
          ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
          ["@lsp.type.selfTypeKeyword"] = { link = "@variable.builtin" },
          ["@lsp.type.lifetime"] = { link = "@keyword.storage" },

          ["@lsp.typemod.class.defaultLibrary"] = { link = "@constructor" },
          ["@lsp.typemod.struct.defaultLibrary"] = { link = "@constructor" },
          ["@lsp.typemod.type.defaultLibrary"] = { link = "@type.builtin" },

          ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
          ["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
          ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.method" },

          ["@lsp.typemod.keyword.injected"] = { link = "@keyword" },
          ["@lsp.typemod.operator.injected"] = { link = "@operator" },
          ["@lsp.typemod.string.injected"] = { link = "@string" },

          ["@lsp.typemod.variable.callable"] = { link = "@function" },
          ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
          ["@lsp.typemod.variable.injected"] = { link = "@variable" },
          ["@lsp.typemod.variable.static"] = { link = "@constant" },
        }
      end,
    })
  end,
}
-- red = '#F6598E',
-- orange = '#F09262',
-- yellow = '#EDE874',
-- lime = '#C2E774',
-- green = '#91E478',
-- aqua = '#83EDCF',
-- skye = '#86DCE9',
-- snow = '#83C4E6',
-- blue = '#7796DF',
-- purple = '#8B79E8',
-- violet = '#B37FED',
-- pink = '#F186ED',
-- cherry = '#CC6D91'

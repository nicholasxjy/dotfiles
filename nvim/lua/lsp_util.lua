local M = {}

function M.add_schemastore(kind)
  return function(_, config)
    require("loader").packadd("SchemaStore.nvim")
    local schemastore = require("schemastore")

    if kind == "json" then
      config.settings.json = vim.tbl_deep_extend("force", config.settings.json or {}, {
        schemas = schemastore.json.schemas(),
        validate = { enable = true },
      })
      return
    end

    config.settings.yaml = vim.tbl_deep_extend("force", config.settings.yaml or {}, {
      schemaStore = { enable = false, url = "" },
      schemas = schemastore.yaml.schemas(),
    })
  end
end

function M.insert_package_json(root_files, field, filename)
  local package_files = vim.fs.find({ "package.json", "package.json5" }, {
    path = vim.fs.dirname(filename),
    upward = true,
    type = "file",
  })

  for _, path in ipairs(package_files) do
    local file = assert(io.open(path, "r"))
    for line in file:lines() do
      if line:find(field, 1, true) then
        root_files[#root_files + 1] = vim.fs.basename(path)
        break
      end
    end
    file:close()
  end

  return root_files
end

return M

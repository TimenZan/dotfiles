-- Language-servers for data files
return {
    { yamlls = { settings = { jaml = { schemaStore = { enable = false, url = "" }, schemas = require 'schemastore'.yaml.schemas(), }, }, }, },
    { jsonls = { settings = { json = { schemas = require 'schemastore'.json.schemas(), validate = { enable = true }, }, }, }, },
    { taplo = {} }, -- Toml files
    { lemminx = { settings = { xml = { catalogs = { vim.fn.expand("$HOME/etc/xml/catalog") }, }, }, }, },
}

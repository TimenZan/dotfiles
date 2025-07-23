-- Language-servers for data files
return {
    { yamlls = {} },
    { jsonls = {} },
    { taplo = {} }, -- Toml files
    { lemminx = { settings = { xml = { catalogs = { vim.fn.expand("$HOME/etc/xml/catalog") } } } } },
}

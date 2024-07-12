return {
    { pyright = {} },
    {
        pylsp = {
            settings = {
                pyslp = {
                    plugins = {
                        black = {
                            enabled = true,
                            cache_config = true,
                        },
                        pycodestyle = {
                            ignore = {},
                            maxLineLength = 100,
                        },
                    },
                },
            },
        }
    },
}

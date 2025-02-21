return {
    { pyright = {} },
    {
        pylsp = {
            settings = {
                pyslp = {
                    plugins = {
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

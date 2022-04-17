require 'dressing'.setup {
    input = {
        insert_only = false,
    },
    select = {
        backend = { 'telescope' }
    },
}
require 'glow-hover'.setup {
    max_width = 50,
    padding = 10,
    border = 'shadow',
}

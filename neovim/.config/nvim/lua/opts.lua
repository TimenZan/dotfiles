vim.opt.autowrite = true
vim.opt.diffopt:append "algorithm:patience"
vim.opt.diffopt:append "linematch:300"
vim.opt.fillchars = { fold = "⁑" }
vim.opt.foldtext = ""
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.scrolloff = 5
vim.opt.shiftround = true
vim.opt.showmode = false
vim.opt.sidescrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.updatetime = 100
vim.opt.winborder = "single"
vim.opt.wrap = false
vim.opt_global.formatoptions:append "ro/n1l"
-- TODO: only set for certain filetypes?
-- vim.opt_global.formatoptions:append "a"
vim.opt_global.shortmess:append "c"


vim.opt.number = true
vim.opt.relativenumber = true

local dont_number_ft = { help = true, lazy = true, ['neotest-summary'] = true, DressingInput = true, }

local numbertoggle = vim.api.nvim_create_augroup("numbertoggle-3f649135-8322-4918-a0a1-2083c6527e92", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
    group = numbertoggle,
    callback = function (args)
        if not dont_number_ft[vim.bo.filetype] then
            vim.opt.relativenumber = true
        end
    end
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
    group = numbertoggle,
    callback = function (args)
        if not dont_number_ft[vim.bo.filetype] then
            vim.opt.relativenumber = false
        end
    end
})

local highlightYank = vim.api.nvim_create_augroup("highlightYank-c1065828-0dc6-4433-ad56-b479f24ec397", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlightYank,
    callback = function (args)
        vim.highlight.on_yank { timeout = 500 }
    end
})

vim.diagnostic.config {
    virtual_text = false,
    virtual_lines = true,
    -- virtual_lines = { highlight_whole_line = false },
}

vim.keymap.set('n', 'gK', function ()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

-- Disable for pseudo-diagnostics created by `lazy.nvim`
local lazy_namespace = vim.api.nvim_create_namespace('lazy')
vim.diagnostic.config({ virtual_lines = false }, lazy_namespace)


-- set cpoptions+="n"
-- set showbreak="⮑ "
-- set showbreak="++++ "
-- set breakindent
-- set breakindentopt+="sbr,list:-1"

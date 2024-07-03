vim.opt.autowrite = true
vim.opt.fillchars = { fold = "⁑" }
vim.opt.foldtext = ""
vim.opt_global.formatoptions:append "ro/n1l"
vim.opt_global.formatoptions:append "a"
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.scrolloff = 5
vim.opt.shiftround = true
vim.opt.shortmess:append "c"
vim.opt.sidescrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.updatetime = 100
vim.opt.wrap = false

vim.opt.number = true
vim.opt.relativenumber = true

local numbertoggle = vim.api.nvim_create_augroup("numbertoggle-3f649135-8322-4918-a0a1-2083c6527e92", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
    group = numbertoggle,
    callback = function(args)
        if vim.bo.filetype ~= "help" then
            vim.opt.relativenumber = true
        end
    end
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
    group = numbertoggle,
    callback = function(args)
        if vim.bo.filetype ~= "help" then
            vim.opt.relativenumber = false
        end
    end
})

local highlightYank = vim.api.nvim_create_augroup("highlightYank-c1065828-0dc6-4433-ad56-b479f24ec397", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlightYank,
    callback = function(args)
        vim.highlight.on_yank { timeout = 500 }
    end
})


-- set cpoptions+="n"
-- set showbreak="⮑ "
-- set showbreak="++++ "
-- set breakindent
-- set breakindentopt+="sbr,list:-1"

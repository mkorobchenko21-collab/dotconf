-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '

-- [[ Setting options ]] See `:h vim.o` (vim optinons)
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:help option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

-- Print the line number in front of each line
vim.opt.number = true

-- Use relative line numbers, so that it is easier to jump with j, k. This will affect the 'number'
-- option above, see `:h number_relativenumber`
vim.opt.relativenumber = true

-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
-- vim.api.nvim_create_autocmd('UIEnter', {
--   callback = function()
-- vim.opt.clipboard = 'unnamedplus'
--   end,
-- })

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight the line where the cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Show <tab> and trailing spaces
vim.opt.list = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s) See `:help 'confirm'`
vim.opt.confirm = true

-- [[ Basic Autocommands ]].
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    callback = function()
        vim.hl.on_yank()
    end,
})

-- [[ Add optional packages ]]
-- Nvim comes bundled with a set of packages that are not enabled by
-- default. You can enable any of them by using the `:packadd` command.

-- For example, to add the "nohlsearch" package to automatically turn off search highlighting after
-- 'updatetime' and when going to insert mode
-- vim.cmd('packadd! nohlsearch')


-- #
-- # My config
-- #
vim.opt.foldcolumn = "auto"

vim.opt.spell = false

-- Make cursor in Insertion mode as a block
vim.opt.guicursor = "i:block-blinkon700-blinkoff300"

-- Show thin line on the 120s columns
vim.opt.colorcolumn = "120"

-- [[Indentation]]
-- \t = 4 spaces
vim.opt.tabstop = 4

-- Tabs in Insertion mode
vim.opt.softtabstop = 4

-- Tabs via >> / <<
vim.opt.shiftwidth = 4

-- Tab in 4 spaces
vim.opt.expandtab = true

-- Invisible characters
vim.opt.list = true
vim.opt.listchars = {
    tab = " ",
    multispace = "-",
    trail = "-", -- spaces at the eol
    eol = "󰌑"
}

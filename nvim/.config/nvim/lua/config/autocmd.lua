-- vim.api.nvim_create_augroup('custom buffers', {})

vim.api.nvim_create_autocmd("TermOpen", {
    -- group = "custom buffers",
    -- pattern = "*",
    command = "startinsert | set winfixheight"
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { 'c,', 'cpp' },
    callback = function()
        -- bo - buffer options
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.shiftwidth = 2
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = 'help',
    callback = function()
        vim.opt_local.nu = true
        vim.opt_local.colorcolumn = ''
        -- TODO: check opts buffer in keymap.set()
        vim.keymap.set('n', 'q', '<cmd>:close<CR>', { buffer = true, silent = true })
    end
})

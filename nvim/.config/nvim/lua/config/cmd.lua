-- [[ Create user commands ]]
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
    local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
    local filename = vim.api.nvim_buf_get_name(0)
    print(vim.fn.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }))
end, { desc = 'Print the git blame for the current line' })


-- Edit neovim config
vim.api.nvim_create_user_command(
    'Econf',
    function()
        vim.cmd.edit(vim.fn.stdpath('config'))
    end,
    { desc = 'Open neovim config dir' }
)

vim.api.nvim_create_user_command(
    'Translate',
    function()
        local word = vim.fn.expand('<cword>')
        local on_exit = function()
            print('translating the word: ' .. word)
        end
        vim.system(
            { 'firefox', '-new-tab', 'https://translate.google.com/?sl=auto&tl=uk&text=' .. word .. '&op=translate' },
            on_exit)
    end,
    { desc = '' }
)

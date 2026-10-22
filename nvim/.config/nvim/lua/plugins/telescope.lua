return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    -- cmd = {},
    -- keys = {
    --     {'<leader> ', '<cmd>Telescope find_files<CR>'},
    --     {'<leader>fb', '<cmd>Telescope buffers<CR>'},
    --     {'<leader>fg', '<cmd>Telescope live_grep<CR>'},
    --     {'<leader>fh', '<cmd>Telescope help_tags<CR>'},
    -- }
}

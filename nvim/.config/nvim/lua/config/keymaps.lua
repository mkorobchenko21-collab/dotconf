-- TODO: make { desc = '' }
-- NOTE: [[ Set up keymaps ]] See `:h map()`, `:h mapping`, `:h keycodes`

local map = vim.keymap.set
local opt = {
    noremap = true,
    silent = true
}

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- better indenting
map("x", ">", ">gv")
map("x", "<", "<gv")

-- Unmap Ctrl+q (same as Ctrl+v)
map('n', '<C-q>', '', opt)

-- Use <Esc> to exit terminal mode
map('t', '<Esc>', '<C-\\><C-n>')
map({ 'n', 'i' }, '<ESC>', function()
    vim.cmd("nohlsearch")
    return "<esc>"
end, { expr = true })


-- Map <C-{hjkl}> to navigate between windows in any modes
map({ 't', 'i' }, '<C-h>', '<C-\\><C-n><C-w>h', { remap = true, silent = true })
map({ 't', 'i' }, '<C-j>', '<C-\\><C-n><C-w>j', { remap = true, silent = true })
map({ 't', 'i' }, '<C-k>', '<C-\\><C-n><C-w>k', { remap = true, silent = true })
map({ 't', 'i' }, '<C-l>', '<C-\\><C-n><C-w>l', { remap = true, silent = true })
map({ 'n' }, '<C-h>', '<C-w>h', { remap = true, silent = true })
map({ 'n' }, '<C-j>', '<C-w>j', { remap = true, silent = true })
map({ 'n' }, '<C-k>', '<C-w>k', { remap = true, silent = true })
map({ 'n' }, '<C-l>', '<C-w>l', { remap = true, silent = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- move lines around
map('i', '<a-j', '<esc><cmd>move .+1<CR>==gi')
map('i', '<a-k', '<esc><cmd>move .-2<CR>==gi')
map('n', '<a-j>', '<cmd>move .+1<CR>==')
map('n', '<a-k>', '<cmd>move .-2<CR>==')
map('v', '<a-j>', ":move '>+1<CR>gv=gv")
map('v', '<a-k>', ":move '<-2<CR>gv=gv")

-- Buffers
map('n', '<leader>n', ':bnext<CR>', opt)
map('n', '<leader>N', ':bprev<CR>', opt)
map('n', '<leader>bd', ':bd<CR>', opt)
map('n', '<leader>bl', ':ls<CR>', opt)
map('n', '<leader>bc', function() vim.api.nvim_buf_set_lines(0, 0, -1, false, {}) end,
    { desc = 'Clear buffer content' })

-- Tabs
map('n', '<leader>tn', ':tabnew<CR>', opt)
map('n', '<leader>tN', ':tabnew$<CR>', opt)
map('n', '<leader>td', ':tabclose<CR>', opt)
map('n', '<s-h>', ':tabprev<CR>', opt)
map('n', '<s-l>', ':tabnext<CR>', opt)
map('n', '<leader>tt', ':tabnew +terminal<CR>', opt)

--  tab navigation
for i = 1, 9, 1 do
    map('n', '<leader>' .. i, i .. 'gt')
end
map('n', '<leader>0', ':tablast<CR>')

-- moving tabs
for i = 1, 9, 1 do
    map('n', i .. 'H', ':tabmove -' .. i .. '<CR>')
    map('n', i .. 'L', ':tabmove +' .. i .. '<CR>')
end


-- windows
map("n", "<leader>wh", ":split<CR>", opt)
map("n", "<leader>wv", ":vsplit<CR>", opt)
map('n', '<leader>wc', ':close<CR>', opt)

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- file actions
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map('n', '<leader>ff', vim.lsp.buf.format, { desc = 'format file' })
map('n', '<leader>fc', function()
    vim.cmd.edit(vim.fn.stdpath("config"))
end
)
map('n', '<leader>fy', '<cmd>let @+ = @%<cr>', { desc = 'yank file path in system register' })
map('n', '<leader>fs', '<cmd>source $MYVIMRC<CR>', { desc = 'source neovim config' })
map('n', '<leader>fp', '<cmd>echo expand("%:p")<CR>', { desc = 'see current file path' })
map('n', '<leader>ft', function()
        local word = vim.fn.expand('<cword>')
        local on_exit = function()
            print('translating the word: ' .. word)
        end
        vim.system(
            { 'firefox', '-new-tab', 'https://translate.google.com/?sl=auto&tl=uk&text=' .. word .. '&op=translate' },
            on_exit)
    end,
    { desc = 'translate the word under the cursor' })

map('x', '<leader>ft', function()
        local _, start_line, _ = unpack(vim.fn.getpos('v'))
        local _, end_line, _ = unpack(vim.fn.getpos('.'))

        if end_line < start_line then
            start_line, end_line = end_line, start_line
        end

        local text = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, true)
        local textstr = table.concat(text, '\n')

        local on_exit = function()
            print('translating the lines: ' .. start_line .. '-' .. end_line)
        end
        vim.system(
            { 'firefox', '-new-tab', 'https://translate.google.com/?sl=auto&tl=uk&text=' .. textstr .. '&op=translate' },
            on_exit)
    end,
    { desc = 'translate selected lines' })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- lazy
map('n', '<leader>l', '<cmd>Lazy<CR>', opt)

-- clipboard
map('n', '+', '"+')
map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>p', '"+p')

-- code actions
-- NOTE: others code actions keymaping in plugins/lsp
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'check message' })
map('n', '<leader>cy', ':%y+<CR>', { desc = 'yank whole file' })

-- vim options changes
map('n', '<leader>os', '<cmd>setlocal spell!<CR>', { desc = 'toggle spell checking' })
map('n', '<leader>or', '<cmd>setlocal relativenumber!<CR>', { desc = 'toggle relativenumber option' })
map('n', '<leader>ow', '<cmd>setlocal wrap!<CR>', { desc = 'toggle wrapping lines' })

-- code navigations
-- NOTE: <c-a> was to paste last inserted text
map('i', '<c-a>', '<esc>A', { desc = 'move cursor to the EOL' })

-- Explorer
-- TODO: optionaly switch to neotree
map("n", "<leader>e", ":Explore<CR>", opt)
-- map("n", "<leader>e", ":30Lexplore<CR>", opt)

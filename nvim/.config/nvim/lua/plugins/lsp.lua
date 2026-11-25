return {
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        keys = {
            { "<c-space>",  "<c-x><c-o>",                                       mode = { "i" } },
            { "gd",         vim.lsp.buf.definition,                             desc = "Goto Definition" },
            { "gr",         vim.lsp.buf.references,                             desc = "References",                 nowait = true },
            { "gI",         vim.lsp.buf.implementation,                         desc = "Goto Implementation" },
            { "gD",         vim.lsp.buf.declaration,                            desc = "Goto Declaration" },
            { "K",          function() return vim.lsp.buf.hover() end,          desc = "Hover" },
            { "gK",         function() return vim.lsp.buf.signature_help() end, desc = "Signature Help" },
            { "<leader>ca", vim.lsp.buf.code_action,                            desc = "Code Action",                mode = { "n", "x" } },
            { "<leader>cr", vim.lsp.buf.rename,                                 desc = "Rename" },

            vim.lsp.config('copilot', {
                cmd = { 'copilot-language-server', '--stdio' },
                root_markers = { '.git' },
                init_options = {
                    editorInfo = {
                        name = 'Neovim', version = tostring(vim.version()) },
                    editorPluginInfo = { name = 'Neovim', version = tostring(vim.version()) },
                },
            })

            vim.lsp.enable("copilot")

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.name == "copilot" then
                        vim.lsp.inline_completion.enable(true, { bufnr = args.buf })
                    end
                end,
            })

            vim.keymap.set("i", "<M-l>", function()
                    vim.lsp.inline_completion.get()
                end,
                { desc = "Accept Copilot inline completion" })
        end
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "pyright",
                "clangd",
                "bashls",
                "cmake",
                "cssls",
                "html",
                "jsonls",
                "copilot",
            },
        },
    }
}

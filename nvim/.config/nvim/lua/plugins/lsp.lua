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
        config = function()
            -- vim.lsp.enable({ "clangd", "pyright", "lua_ls", "bashls" })

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

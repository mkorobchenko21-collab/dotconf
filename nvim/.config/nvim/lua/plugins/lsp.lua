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

            { "<leader>cc", vim.lsp.codelens.run,                               desc = "Run Codelens",               mode = { "n", "x" } },
            { "<leader>cC", vim.lsp.codelens.refresh,                           desc = "Refresh & Display Codelens", mode = { "n" } },
        },
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
                "roslyn_ls"
            },
        },
    }
}

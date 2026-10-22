return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        opts = {
            indent = { enable = true },
            highlight = { enable = true },
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "printf",
                "python",
                "query",
                "regex",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        init = function()
            -- Disable built-in ftplugin mappings to avoid conflicts with custom keymaps
            vim.g.no_plugin_maps = true
        end,
        config = function()
            local textobjects = require("nvim-treesitter-textobjects")
            local move = require("nvim-treesitter-textobjects.move")

            textobjects.setup({
                move = {
                    enable = true,
                    set_jumps = true, -- Record jumps in the jumplist (<C-o> / <C-i>)
                },
            })

            -- Movement Keymaps with which-key descriptions
            local maps = {
                -- Next start
                { key = "]m", query = "@function.outer", group = "textobjects", fn = move.goto_next_start,     desc = "Next function start" },
                { key = "]]", query = "@class.outer",    group = "textobjects", fn = move.goto_next_start,     desc = "Next class start" },
                { key = "]a", query = "@parameter.inner",group = "textobjects", fn = move.goto_next_start,     desc = "Next parameter start" },
                { key = "]o", query = { "@loop.inner", "@loop.outer" }, group = "textobjects", fn = move.goto_next_start, desc = "Next loop start" },
                { key = "]s", query = "@local.scope",    group = "locals",      fn = move.goto_next_start,     desc = "Next scope start" },
                { key = "]z", query = "@fold",           group = "folds",       fn = move.goto_next_start,     desc = "Next fold start" },

                -- Next end
                { key = "]M", query = "@function.outer", group = "textobjects", fn = move.goto_next_end,       desc = "Next function end" },
                { key = "][", query = "@class.outer",    group = "textobjects", fn = move.goto_next_end,       desc = "Next class end" },
                { key = "]A", query = "@parameter.inner",group = "textobjects", fn = move.goto_next_end,       desc = "Next parameter end" },

                -- Previous start
                { key = "[m", query = "@function.outer", group = "textobjects", fn = move.goto_previous_start, desc = "Prev function start" },
                { key = "[[", query = "@class.outer",    group = "textobjects", fn = move.goto_previous_start, desc = "Prev class start" },
                { key = "[a", query = "@parameter.inner",group = "textobjects", fn = move.goto_previous_start, desc = "Prev parameter start" },

                -- Previous end
                { key = "[M", query = "@function.outer", group = "textobjects", fn = move.goto_previous_end,   desc = "Prev function end" },
                { key = "[]", query = "@class.outer",    group = "textobjects", fn = move.goto_previous_end,   desc = "Prev class end" },
                { key = "[A", query = "@parameter.inner",group = "textobjects", fn = move.goto_previous_end,   desc = "Prev parameter end" },

                -- Conditionals (closest start/end)
                { key = "]d", query = "@conditional.outer", group = "textobjects", fn = move.goto_next,     desc = "Next conditional" },
                { key = "[d", query = "@conditional.outer", group = "textobjects", fn = move.goto_previous, desc = "Prev conditional" },
            }

            for _, map in ipairs(maps) do
                vim.keymap.set({ "n", "x", "o" }, map.key, function()
                    map.fn(map.query, map.group)
                end, { desc = map.desc })
            end
        end,
    },
}

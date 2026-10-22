return {
    "vim-scripts/dbext.vim",
    ft = { "sql", "pgsql" },
    init = function()
        vim.g.dbext_default_profile = "maximus"
        -- vim.g.dbext_default_profile_my_profile = "type=PGSQL:user=postgres:passwd=root:dbname=mydb"
    end,
}

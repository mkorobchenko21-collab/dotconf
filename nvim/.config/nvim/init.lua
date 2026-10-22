require("config.options")
require("config.keymaps")
require("config.cmd")
require("config.autocmd")
-- require("pack")

require("config.lazy")

vim.cmd('colo habamax')

-- for :find
vim.opt.path:append(vim.fn.stdpath("config") .. "/**")

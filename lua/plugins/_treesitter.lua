return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        local treesitter = require("nvim-treesitter.configs")

            -- configure treesitter
        treesitter.setup({
            highlight = {
                enable = true,
            },
            -- enable indentation
            indent = {
                enable = true,
            },
            -- ensure these language parsers are installed
            ensure_installed = {
                "lua",
                "rust",
                "toml"
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = true,
                    node_decremental = "<bs>",
                }
            }
        })
    end
}

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
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
                "toml",
                "svelte",
                "go",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = "<S-v>",
                    node_decremental = "<bs>",
                }
            }
        })

        print("treesitter config loaded")
    end
}

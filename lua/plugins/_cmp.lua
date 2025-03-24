return {
    "hrsh7th/nvim-cmp",

    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
    },

    config = function()
        local cmp = require("cmp")
        vim.opt.completeopt = {"menu", "menuone", "noselect"}
                
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end
            },
            window = {},
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({select = false}),
            }),
            sources = cmp.config.sources({
                {name = "nvim_lsp"},
                {name = "nvim_lua"},
                {name = "luasnip"},
            },{
                {name = "buffer"},
                {name = "path"},
            })
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    {name = "path"},
                    }, {
                    {name = "cmdline"}, 
                    }),
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("lspconfig").pylsp.setup({
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = {"W391", "E225", "E303", "E711", "E226", "E266", "E275", "W293", "E203", "E302", "E305", "E501", "E231", "W291", "E251"},
                                maxLineLength = 100,
                            }
                        }
                    }
                }
            })

            require("lspconfig").rust_analyzer.setup({
                settings = {
                    ["rust_analyzer"] = {
                        workspace = {
                            symbol = {
                                search = {
                                    kind = "all_symbols"
                                }
                            }
                        }
                    }
                }
            })
        end

}

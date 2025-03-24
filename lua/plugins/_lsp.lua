return {
    {
        "williamboman/mason.nvim",
        lazy = false,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
                require("mason").setup()
                require("mason-lspconfig").setup()
        end
    }
}

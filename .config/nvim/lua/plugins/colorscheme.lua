return {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                -- Your Catppuccin configuration options go here (see step 1)
            })
        end,
}

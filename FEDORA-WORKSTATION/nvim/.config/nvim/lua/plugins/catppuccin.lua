return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- load before UI
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      integrations = {
        treesitter = true,
        telescope = true,
        which_key = true,
        native_lsp = {
          enabled = true,
        },
      },
    })
    -- Defer setting the colorscheme to after UI loads
    vim.api.nvim_create_autocmd("User", {
      pattern = "AstroColorScheme",
      callback = function()
        vim.cmd.colorscheme("catppuccin")
      end,
    })
  end,
}


return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("catppuccin")
  end,
 
  opts = {
    flavour = "mocha",
    transparent_background = true,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      treesitter = true,
      telescope = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      -- Add any other integrations you want here
    },
  },
}

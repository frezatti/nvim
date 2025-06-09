-- lua/plugins/treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- The 'opts' table will be passed to the plugin's .setup() function automatically.
  opts = {
    ensure_installed = { "javascript", "go", "typescript", "rust", "cpp", "c", "lua", "vim", "ruby","vimdoc", "query" },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
  config = function(_, opts)
    -- The 'config' function is still needed here to call the setup function from the correct module.
    require("nvim-treesitter.configs").setup(opts)
  end,
}

return {
  "mfussenegger/nvim-dap",
  cmd = { "DapContinue", "DapToggleBreakpoint" },
  keys = {
    { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "DAP: Toggle Breakpoint" },
    { "<leader>dc", "<cmd>DapContinue<cr>", desc = "DAP: Continue" },
  },
}

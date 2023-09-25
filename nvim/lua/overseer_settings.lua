local overseer = require('overseer');

overseer.setup({
  -- strategy = {
  --   "toggleterm",
  --   direction='float',
  --   -- load your default shell before starting the task
  --   use_shell = false,
  --   -- have the toggleterm window close automatically after the task exits
  --   close_on_exit = false,
  --   -- open the toggleterm window when a task starts
  --   open_on_start = false,
  --    hidden = false
  -- }
})

-- vim.keymap.set('n', '<leader>oc', '<cmd>OverseerRunCmd<cr>', {})
-- vim.keymap.set('n', '<leader>or', '<cmd>OverseerRun<cr>', {})
-- vim.keymap.set('n', '<leader>oa', '<cmd>OverseerQuickAction<cr>', {})
-- vim.keymap.set('n', '<leader>ot', '<cmd>OverseerToggle<cr>', {})
-- vim.keymap.set('n', '<leader>ol', '<cmd>OverseerRestartLast<cr>', {})

vim.api.nvim_create_user_command("OverseerRestartLast", function()
  local overseer = require("overseer")
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end, {})

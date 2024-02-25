local project_files = function()
  local opts = {} -- define here if you want to define something
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require"telescope.builtin".git_files({show_untracked = true})
  else
    require"telescope.builtin".find_files(opts)
  end
end

return { 
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<C-p>', project_files, {})
            vim.keymap.set('n', '<C-g>', builtin.live_grep, {})

            local wk = require("which-key")

            wk.register({
                f = {
                    name = "Find (Telescope)",
                    f = {builtin.find_files, "Files"},
                    g = {
                        name = "Git",
                        f = {builtin.git_files, "Files"},
                        c = {builtin.git_commits, "Commits"},
                        s = {builtin.git_status, "Status"},
                        b = {builtin.git_branches, "Branches"},
                    },
                    l = {builtin.live_grep, "Live grep"},
                    q = {builtin.quickfix, "Quickfix"},
                    a = {builtin.builtin, "List all builtin"},
                }
            }, {prefix = "<leader>"})
            -- vim.keymap.set('n', '<leader>ff', builtin.find_files)
            -- vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
            -- vim.keymap.set('n', '<leader>fa', builtin.builtin, {})
            -- vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
            -- vim.keymap.set('n', '<leader>fq', builtin.quickfix, {})
        end
    }
}

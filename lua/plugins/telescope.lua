return {
  'nvim-telescope/telescope.nvim',
      keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'

    -- https://github.com/MagicDuck/grug-far.nvim/pull/305
    local is_windows = vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1
    local vimfnameescape = vim.fn.fnameescape
    local winfnameescape = function(path)
      local escaped_path = vimfnameescape(path)
      if is_windows then
        local need_extra_esc = path:find('[%[%]`%$~]')
        local esc = need_extra_esc and '\\\\' or '\\'
        escaped_path = escaped_path:gsub('\\[%(%)%^&;]', esc .. '%1')
        if need_extra_esc then
          escaped_path = escaped_path:gsub("\\\\['` ]", '\\%1')
        end
      end
      return escaped_path
    end

    local select_default = function(prompt_bufnr)
      vim.fn.fnameescape = winfnameescape
      local result = actions.select_default(prompt_bufnr, "default")
      vim.fn.fnameescape = vimfnameescape
      return result
    end

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<cr>'] = select_default,
          },
          n = {
            ['<cr>'] = select_default,
          }
        },
      },
    }
  end
}
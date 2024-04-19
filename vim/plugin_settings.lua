-- NOTE: must be called after plug#end()

---------------- tree sitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Run Treesiter + vim-syntax at the same time (like for indentation).
    additional_vim_regex_highlighting = true,
  },
  indent = {
    -- enable = true
    enable = false
  }
}


--------treesiter-textobjects
require'nvim-treesitter.configs'.setup {
  textobjects = {

    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      -- no need for *n* for action-next-motion, it just goes to next
      lookahead = true,

      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ac"] = "@comment.outer",
        ["ic"] = "@comment.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
      },

      -- Note: only affects y,d actions,  use Vaf to linewise visual select
      selection_modes = {
        ['@function.outer'] = 'V', -- linewise
      },
    },

    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[F"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },

  },
}

-- Available text-objects
-- @block.inner
-- @block.outer
-- @call.inner
-- @call.outer
-- @class.inner
-- @class.outer
-- @comment.outer
-- @conditional.inner
-- @conditional.outer
-- @frame.inner
-- @frame.outer
-- @function.inner
-- @function.outer
-- @loop.inner
-- @loop.outer
-- @parameter.inner
-- @parameter.outer
-- @scopename.inner
-- @statement.outer

-- Telescope
require("telescope").setup {
  defaults = {
    path_display = { "truncate" },
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
    },
  }
}

-- fzy sorter instead
require('telescope').load_extension('fzy_native')

-- https://github.com/numToStr/Comment.nvim
require('Comment').setup()

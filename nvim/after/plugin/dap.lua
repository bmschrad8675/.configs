require('dap-python').setup(os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python')
require("nvim-dap-virtual-text").setup()
-- dap setup
local dap = require('dap')
local dcud_config = {
  type = 'python';
  request = 'attach';
  name = 'Attach remote DCUD';
  connect = {
          host = '127.0.0.1';
          port = 5678;
  };
  cwd = vim.fn.getcwd();
  pathMappings = {
      {
          localRoot = vim.fn.getcwd(); -- Wherever your Python code lives locally.
          remoteRoot = "/app"; -- Wherever your Python code lives in the container.
      };
  };
}
table.insert(require('dap').configurations.python, dcud_config)

-- nvim dap ui configs
local dapui = require("dapui")
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = {
        "scopes",
      },
      size = 0.3,
      position = "right"
    },
    {
      elements = {
        "repl",
        "breakpoints"
      },
      size = 0.3,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil,
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- REMAPS
vim.keymap.set('n', '<F6>', function() require('dap').continue() end)
vim.keymap.set('n', '<C-F6>', function() require('dap').terminate() end)
vim.keymap.set('n', '<F7>', function() require('dap').run(dcud_config) end)

vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

-- Tests
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      runner = "unittest",
    }),
    require("neotest-plenary"),
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua" },
    }),
  },
})

vim.keymap.set('n', '<Leader>tt', function() require("neotest").run.run() end)
vim.keymap.set('n', '<Leader>tf', function() require("neotest").run.run(vim.fn.expand("%")) end)
vim.keymap.set('n', '<Leader>td', function() require("neotest").run.run({strategy = "dap"}) end)
vim.keymap.set('n', '<Leader>ts', function() require("neotest").run.stop() end)
vim.keymap.set('n', '<Leader>ta', function() require("neotest").run.attach() end)

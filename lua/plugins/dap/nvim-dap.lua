return {
  {
    'jay-babu/mason-nvim-dap.nvim',
    config = function ()
      local mason_dap = require('mason-nvim-dap')

      mason_dap.setup({
        ensure_installed = {
          'codelldb',
        },
      })

      -- python
    end
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        config = function ()
          local dap, dapui = require("dap"), require("dapui")
          dapui.setup()
          dap.listeners.before.attach.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.launch.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
          end
          dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
          end
        end
      },
      -- Adapter
      {
        'mfussenegger/nvim-dap-python',
        config = function ()
          require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
        end
      },
    },
    keys = {
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Breakpoint Condition' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
      { '<leader>dc', function() require('dap').continue() end, desc = 'Continue' },
      { '<leader>dC', function() require('dap').run_to_cursor() end, desc = 'Run to Cursor' },
      { '<leader>dg', function() require('dap').goto_() end, desc = 'Go to line (no execute)' },
      { '<leader>di', function() require('dap').step_into() end, desc = 'Step Into' },
      { '<leader>dj', function() require('dap').down() end, desc = 'Down' },
      { '<leader>dk', function() require('dap').up() end, desc = 'Up' },
      { '<leader>dl', function() require('dap').run_last() end, desc = 'Run Last' },
      { '<leader>do', function() require('dap').step_out() end, desc = 'Step Out' },
      { '<leader>dO', function() require('dap').step_over() end, desc = 'Step Over' },
      { '<leader>dp', function() require('dap').pause() end, desc = 'Pause' },
      { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Toggle REPL' },
      { '<leader>ds', function() require('dap').session() end, desc = 'Session' },
      { '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate' },
      { '<leader>dw', function() require('dap.ui.widgets').hover() end, desc = 'Widgets' },
    },
    config = function ()
      local dap_breakpoint = {
        breakpoint = {
          text = "B",
          texthl = "LspDiagnosticsSignError",
          linehl = "WarnLine",
          numhl = "",
        },
        rejected = {
          text = "E",
          texthl = "LspDiagnosticsSignHint",
          linehl = "ErrorLine",
          numhl = "",
        },
        stopped = {
          text = ">",
          texthl = "LspDiagnosticsSignInformation",
          -- linehl = "DiagnosticUnderlineInfo",
          linehl = 'HintLine',
          numhl = "LspDiagnosticsSignInformation",
        },
      }

      vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
      vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
      vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

      local dap = require('dap')

      dap.adapters["codelldb"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = {
            "--port",
            "${port}",
          },
        },
      }

      -- c, cpp, rust
      for _, lang in ipairs({ "c", "cpp", "rust" }) do
        dap.configurations[lang] = {
          {
            type = "codelldb",
            request = "launch",
            name = "Launch file",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
          },
          {
            type = "codelldb",
            request = "attach",
            name = "Attach to process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end
  },
}

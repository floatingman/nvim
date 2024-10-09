local debugging_signs = require("util.icons").debugging_signs

return {
	"mfussenegger/nvim-dap",
   
    dependencies = {
        -- create a beautiful debugger UI
        "rcarriga/nvim-dap-ui",

        -- Required for nvim-dap-ui
        "nvim-neotest/nvim-nio",

        -- Install the debug adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',

        -- Add your own debuggers here
        'mfussenegger/nvim-dap-python',
        'leoluz/nvim-dap-go',
    },
    keys = function(_, keys)
       local dap = require 'dap'
       local dapui = require 'dapui'
       return {
          -- Basic debugging keymaps, feel free to change to your liking!
          { '<F5>', dap.continue, desc = 'Debug: Start/Continue' },
          { '<F1>', dap.step_into, desc = 'Debug: Step Into' },
          { '<F2>', dap.step_over, desc = 'Debug: Step Over' },
          { '<F3>', dap.step_out, desc = 'Debug: Step Out' },
          { '<leader>b', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
          {
            '<leader>B',
            function()
              dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end,
            desc = 'Debug: Set Breakpoint',
          },
          -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
          { '<F7>', dapui.toggle, desc = 'Debug: See last session result.' },
          unpack(keys),
       }
    end,
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- set custom icons
		for name, sign in pairs(debugging_signs) do
			sign = type(sign) == "table" and sign or { sign }
			vim.fn.sign_define(
				"Dap" .. name,
				{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
			)
		end

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup {
          -- Set icons to characters that are more likely to work in every terminal.
          --    Feel free to remove or use ones that you like more! :)
          --    Don't feel like these are good choices.
          icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
          controls = {
            icons = {
              pause = '⏸',
              play = '▶',
              step_into = '⏎',
              step_over = '⏭',
              step_out = '⏮',
              step_back = 'b',
              run_last = '▶▶',
              terminate = '⏹',
              disconnect = '⏏',
            },
          },
        }

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- Install golang specific config
        require('dap-go').setup {
          delve = {
            -- On Windows delve must be run attached or it crashes.
            -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
            detached = vim.fn.has 'win32' == 0,
          },
        }
        end,
}

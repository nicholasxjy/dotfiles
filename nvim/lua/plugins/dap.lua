return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "nvim-dap-view" },
      -- virtual text for the debugger
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      {
        "jbyuki/one-small-step-for-vimkind",
        keys = {
          {
            "<leader>dL",
            function()
              require("osv").launch({ port = 8086 })
            end,
            desc = "Launch OSV",
          },
        },
        config = function()
          local dap = require("dap")

          dap.adapters.nlua = function(callback, config)
            callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
          end
          dap.configurations.lua = {
            {
              type = "nlua",
              request = "attach",
              name = "Attach to running Neovim instance",
            },
          }
        end,
      },
    },
    config = function()
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      vim.fn.sign_define(
        "DapStopped",
        { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" }
      )
      vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticInfo", priority = 1000 })
      vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticInfo", priority = 1000 })
      vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError", priority = 1000 })
      vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo" })
    end,
    keys = {

      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Run/Continue",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dg",
        function()
          require("dap").goto_()
        end,
        desc = "Go to Line (No Execute)",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<leader>dk",
        function()
          require("dap").up()
        end,
        desc = "Up",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dP",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Widgets",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Breakpoint Condition",
      },
    },
  },

  {
    "igorlfs/nvim-dap-view",
    keys = {
      {
        "<leader>du",
        function()
          require("dap-view").toggle()
        end,
        desc = "Toggle nvim-dap-view",
      },
      {
        "<leader>de",
        function()
          require("dap-view").add_expr()
        end,
        desc = "Watch Expression",
        mode = { "n", "x" },
      },
    },
    opts = {
      winbar = {
        controls = { enabled = true },
        sections = { "watches", "exceptions", "breakpoints", "scopes", "threads", "repl", "console" },
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dap_view = require("dap-view")
      dap_view.setup(opts)

      dap.listeners.after.event_initialized["dap-view-config"] = function()
        dap_view.open()
      end
      dap.listeners.before.event_terminated["dap-view-config"] = function()
        dap_view.close()
      end
      dap.listeners.before.event_exited["dap-view-config"] = function()
        dap_view.close()
      end
    end,
  },
}

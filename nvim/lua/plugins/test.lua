return {
  {
    "nvim-neotest/neotest",
    opts = {
      status = {
        virtual_text = true,
      },
      output = {
        open_on_run = false,
      },
      summary = {
        animated = false,
      },
    },
    keys = {
      --stylua: ignore start
      { "<leader>t", "", desc = "+test" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>ta", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
      -- stylua: ignore end
    },
  },
}

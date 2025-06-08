return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    "borderless-full",
    winopts = {
      width = 0.8,
      height = 0.7,
      preview = {
        layout = "vertical",
        vertical = "up:45%",
      },
    },
  },
  keys = {
    {
      "<leader><space>",
      function()
        require("fzf-lua").files()
      end,
      desc = "Find files",
    },
    {
      "<leader>/",
      function()
        require("fzf-lua").lgrep_curbuf()
      end,
      desc = "Grep current buffer",
    },

    {
      "<leader>r",
      function()
        require("fzf-lua").resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>h",
      function()
        require("fzf-lua").buffers({
          sort_lastused = true,
          current = false,
        })
      end,
      desc = "Jump buffers",
    },
    {
      "<leader>m",
      function()
        require("fzf-lua").marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>:",
      function()
        require("fzf-lua").commands()
      end,
      desc = "Commands",
    },
    --find
    {
      "<leader>fa",
      function()
        require("fzf-lua").autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>fb",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>fo",
      function()
        require("fzf-lua").oldfiles()
      end,
      desc = "Oldfiles",
    },
    {
      "<leader>fc",
      function()
        require("fzf-lua").colorschemes()
      end,
      desc = "Colorschemes",
    },
    {
      "<leader>fk",
      function()
        require("fzf-lua").keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>fr",
      function()
        require("fzf-lua").registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>sg",
      function()
        require("fzf-lua").live_grep_native()
      end,
      desc = "Grep",
    },
    {
      "<leader>sG",
      function()
        require("fzf-lua").live_grep_glob()
      end,
      desc = "Grep",
    },
    {
      "<leader>sr",
      function()
        require("fzf-lua").live_grep_resume()
      end,
      desc = "Grep resume",
    },
    {
      "<leader>sw",
      function()
        require("fzf-lua").grep_cword()
      end,
      desc = "Grep word",
      mode = { "n", "x" },
    },
    {
      "<leader>sW",
      function()
        require("fzf-lua").grep_cWORD()
      end,
      desc = "Search word all",
      mode = { "n", "x" },
    },
    {
      "<leader>sv",
      function()
        require("fzf-lua").grep_visual()
      end,
      desc = "Grep visual",
    },
    {
      "<leader>xq",
      function()
        require("fzf-lua").quickfix()
      end,
      desc = "quickfix",
    },
    -- git
    {
      "<leader>gf",
      function()
        require("fzf-lua").git_files()
      end,
      desc = "Git files",
    },
    {
      "<leader>gc",
      function()
        require("fzf-lua").git_commits()
      end,
      desc = "Git commits",
    },
    {
      "<leader>gC",
      function()
        require("fzf-lua").git_bcommits()
      end,
      desc = "Git bcommits",
    },
    {
      "<leader>gb",
      function()
        require("fzf-lua").git_branches()
      end,
      desc = "Git branches",
    },
    {
      "<leader>gB",
      function()
        require("fzf-lua").git_blame()
      end,
      desc = "Git blame",
    },
    {
      "<leader>gs",
      function()
        require("fzf-lua").git_status()
      end,
      desc = "Git Status",
    },
  },
  config = function(_, opts)
    require("fzf-lua").setup(opts)
    require("fzf-lua").register_ui_select()
  end,
}

return {
  "goolord/alpha-nvim",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      "",
      "",
      "",
      "",
      " ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░",
      "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░",
      "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░",
      "░▒▓████████▓▒░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░",
      "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░",
      "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░",
      "░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░",
      "",
      "",
      "",
    }
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", " 󰮗 Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
      dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
      dashboard.button("s", "  Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
      dashboard.button("q", " 󰈆 Quit", ":qa<CR>"),
    }
    dashboard.section.footer.val = {
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    }

    dashboard.config.opts.noautocmd = true

    vim.cmd([[autocmd User AlphaReady echo 'ready']])

    alpha.setup(dashboard.config)
  end,
}

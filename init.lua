--------------------------
-------- LAZYVIM ---------
--------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--------------------------
-------- PLUGINS ---------
--------------------------

local plugins = {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      bigfile = { enabled = true },
      terminal = { 
        enabled = true,
        win = { style = "terminal" }
      },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      lazygit = { enabled = true, configure = true },
      words = { enabled = true },
    },
    keys = {
      -- file picker/explorer
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      -- lazygit
      { "<leader>lg", function() Snacks.lazygit() end, desc = "LazyGit" },
    },
  },
}

require("lazy").setup(plugins, opts)

--------------------------
-------- OPTIONS ---------
--------------------------

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")

-- change command for window management
vim.api.nvim_set_keymap('n', '<leader>w', '<c-w>', { noremap = true })

-- leave :term mode with ESC
vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', { noremap = true})

--------------------------
------ PROJECT CONFIG ----
--------------------------

local function load_project_config()
  local config_file = vim.fn.getcwd() .. "/.nvim.lua"

  if vim.fn.filereadable(config_file) == 1 then
    local ok, config = pcall(dofile, config_file)
    if ok and config then
      -- Enable LSPs specified in the config
      if config.lsp then
        for _, lsp_name in ipairs(config.lsp) do
          vim.lsp.enable(lsp_name)
        end
      end
    else
      vim.notify("Error loading .nvim.lua: " .. tostring(config), vim.log.levels.WARN)
    end
  end
end

-- Load project-specific configuration
load_project_config()


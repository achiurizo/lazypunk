-- lazypunk — a palette-driven colorscheme engine
-- Each variant is a palette table under `lazypunk.palettes.<name>`; the
-- highlight groups in `lazypunk.theme` are variant-agnostic and read only
-- semantic role names, so adding a variant means adding a palette. Nothing else.
local M = {}

--- Load a variant by name (e.g. "lucy", "david").
---@param name string|nil defaults to "lucy"
function M.load(name)
  name = name or "lucy"

  local ok, palette = pcall(require, "lazypunk.palettes." .. name)
  if not ok then
    vim.notify("lazypunk: unknown variant '" .. name .. "'", vim.log.levels.ERROR)
    return
  end

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "lazypunk-" .. name

  local groups = require("lazypunk.theme").build(palette)
  for group, spec in pairs(groups) do
    vim.api.nvim_set_hl(0, group, spec)
  end

  -- ANSI 16 for :terminal
  for i, color in ipairs(palette.ansi) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end
end

return M

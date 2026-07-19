-- Assembles every highlight group from the group modules, given a palette.
-- Group modules are pure `function(palette) -> table<string, vim.api.keyset.highlight>`;
-- later modules win on key collisions (lsp overrides treesitter overrides syntax).
local M = {}

local modules = {
  "cyberpunk.groups.editor",
  "cyberpunk.groups.syntax",
  "cyberpunk.groups.treesitter",
  "cyberpunk.groups.lsp",
}

---@param palette table
---@return table<string, table>
function M.build(palette)
  local groups = {}
  for _, name in ipairs(modules) do
    for group, spec in pairs(require(name)(palette)) do
      groups[group] = spec
    end
  end
  return groups
end

return M

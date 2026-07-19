-- Loads every colors/lazypunk-*.lua colorscheme and fails (nonzero exit) if any
-- raises an error. Run headlessly in CI: nvim --headless -l scripts/check_load.lua
vim.opt.runtimepath:prepend(vim.fn.getcwd())

local failed = {}
for _, f in ipairs(vim.fn.glob('colors/lazypunk-*.lua', false, true)) do
  local cs = vim.fn.fnamemodify(f, ':t:r')
  local ok, err = pcall(function() vim.cmd.colorscheme(cs) end)
  if ok then
    print('ok   ' .. cs)
  else
    failed[#failed + 1] = cs .. ': ' .. tostring(err)
  end
end

if #failed > 0 then
  print('FAILED to load:')
  for _, m in ipairs(failed) do print('  ' .. m) end
  os.exit(1)
end

print('all colorschemes loaded cleanly')

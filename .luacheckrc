-- luacheck config for the lazypunk colorscheme + generator scripts.
std = "lua51"
-- `vim` is Neovim's ambient API (its fields are assigned, so it's writable);
-- `arg` is the `-l` script argument table.
globals = { "vim" }
read_globals = { "arg" }
max_line_length = false

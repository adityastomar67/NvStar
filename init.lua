local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
  impatient.enable_profile()
end

for _, source in ipairs({
  
  -- CORE
  "core.plugins",
  "core.maps",
  "core.options",  
  "core.utils",
  "core.autocmds",

  -- PLUGS
  "plug.whichkey",
  "plug.nvim-tree",
  "plug.ts-context",
  "plug.terminal",
  "plug.telescope",  
  "plug.mason",
  "plug.cmp",
  "plug.lsp",
  "plug.lsp-installer",
  
}) do
local status_ok, fault = pcall(require, source)
if not status_ok then
  vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
end
end

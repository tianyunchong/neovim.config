local colorscheme = "tokyonight"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " 没有找到！")
  return
end


--- 设置html缩进
vim.api.nvim_exec([[
  autocmd FileType html setlocal shiftwidth=2 tabstop=2
]], false)

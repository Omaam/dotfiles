-- Common toggle settings.
require("toggle")
toggleApp("alacritty", ".")
toggleApp("Code", "v")  -- Visual Studio Code
toggleApp("Google Chrome", "c")


-- Load local settings.
local initLocal = "init-local"
if pcall(require, initLocal) then
  require(initLocal)
end

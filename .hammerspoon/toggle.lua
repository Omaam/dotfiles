function toggleApp(appName, key)
  hs.hotkey.bind({"control", "Shift"}, key, function()
    local app = hs.application.get(appName)
    if app == nil then
      hs.application.launchOrFocus("/Applications/" .. appName .. ".app")
    elseif app:isFrontmost() then
      app:hide()
    else
      hs.application.launchOrFocus("/Applications/" .. appName .. ".app")
    end
  end)
end

-- Usage
--   toggleApp("<app_name>", "<launch_key>")
-- Example
--   toggleApp("Google Chrome"", "c")

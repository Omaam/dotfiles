function getAppPath(appName)
  local appPath = "/Applications/" .. appName .. ".app"
  if not hs.fs.attributes(appPath, "mode") then
    appPath = "/System/Applications/" .. appName .. ".app"
  end
  return appPath
end


function toggleApp(appName, key)
  -- Usage
  --   toggleApp("app_name", "launch_key")
  -- Example
  --   toggleApp("Google Chrome", "c")
  hs.hotkey.bind({"ctrl", "shift"}, key, function()

    local app = hs.application.get(appName)
    local appPath = getAppPath(appName)

    if not app then
      if appPath then
        hs.application.launchOrFocus(appPath)
      end
    elseif app:isFrontmost() then
      app:hide()
    else
      -- Some applications cannot be activated by launchOrFocus (e.g., VSCode).
      if not hs.application.launchOrFocus(appPath) then
        app:activate()
      end
    end
  end)
end

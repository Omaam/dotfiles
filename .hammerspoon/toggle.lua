function getAppPath(appName)
  local home = os.getenv("HOME")
  local targetPaths = {
    "/Applications",
    "/System/Applications",
    home .. "/Applications/Chrome Apps.localized"
  }

  for _, appPath in ipairs(targetPaths) do
    if hs.fs.attributes(appPath, "mode") then
      local appNamePath = appPath .. "/" .. appName .. ".app"
      if hs.fs.attributes(appNamePath, "mode") then
        return appNamePath
      end
    end
  end

  local appNamePath = searchExceptions(appName)
  return appNamePath

end


function searchExceptions(appName)
  local exceptions = {
    -- Add exceptions below.
    Code = "/Applications/Code.app"
  }
  for key, value in pairs(exceptions) do
    if key == appName then
      return value
    end
  end
  return nil
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

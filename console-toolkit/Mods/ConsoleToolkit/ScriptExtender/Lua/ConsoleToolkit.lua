-- BG3 Script Extender console toolkit bootstrap.
-- Modules are loaded from Lua/Modules/*.lua by BootstrapServer.lua.

ConsoleToolkit = ConsoleToolkit or {}
ConsoleToolkit.modules = ConsoleToolkit.modules or {}

function ConsoleToolkit.out(msg)
  local text = tostring(msg)
  if Ext and Ext.Utils and Ext.Utils.Print then
    Ext.Utils.Print(text)
  else
    print(text)
  end
end

local function toolkit_help()
  ConsoleToolkit.out("=== ConsoleToolkit Modules ===")
  ConsoleToolkit.out("Mods.ConsoleToolkit.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.inspiration.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.status.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.items.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.party.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.resources.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.character.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.trade.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.teleport.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.paladin.help()")
end

-- Short alias for Script Extender console calls.
help = toolkit_help

ConsoleToolkit.out("ConsoleToolkit core loaded. Run Mods.ConsoleToolkit.help()")

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

function ConsoleToolkit.help()
  ConsoleToolkit.out("=== ConsoleToolkit Modules ===")
  ConsoleToolkit.out("ConsoleToolkit.help()")
  ConsoleToolkit.out("ConsoleToolkit.inspiration.help()")
  ConsoleToolkit.out("ConsoleToolkit.status.help()")
  ConsoleToolkit.out("ConsoleToolkit.items.help()")
  ConsoleToolkit.out("ConsoleToolkit.party.help()")
  ConsoleToolkit.out("")
  ConsoleToolkit.out("When calling through the mod table, use:")
  ConsoleToolkit.out("Mods.ConsoleToolkit.ConsoleToolkit.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.ConsoleToolkit.inspiration.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.ConsoleToolkit.status.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.ConsoleToolkit.items.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.ConsoleToolkit.party.help()")
  ConsoleToolkit.out("Short aliases are also exposed as:")
  ConsoleToolkit.out("Mods.ConsoleToolkit.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.inspiration.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.status.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.items.help()")
  ConsoleToolkit.out("Mods.ConsoleToolkit.party.help()")
end

-- Short aliases for Script Extender console calls through Mods.ConsoleToolkit.*.
help = ConsoleToolkit.help

ConsoleToolkit.out("ConsoleToolkit core loaded. Run ConsoleToolkit.help()")

-- Teleport console helpers.

ConsoleToolkit = ConsoleToolkit or {}
ConsoleToolkit.modules = ConsoleToolkit.modules or {}
ConsoleToolkit.teleport = ConsoleToolkit.teleport or {}
ConsoleToolkit.modules.teleport = ConsoleToolkit.teleport

-- Short alias for Script Extender console calls through Mods.ConsoleToolkit.*.
teleport = ConsoleToolkit.teleport

local function out(msg)
  ConsoleToolkit.out(msg)
end

function ConsoleToolkit.teleport.help()
  out("=== ConsoleToolkit.teleport Commands ===")
  out("ConsoleToolkit.teleport.to_host(<character_uuid>)")
  out("ConsoleToolkit.teleport.companions_to_host()")
  out("Tip: companion teleports use constants.companion_uuids and skip the current host character.")
end

function ConsoleToolkit.teleport.to_host(character_id)
  local host = GetHostCharacter()

  Osi.TeleportTo(character_id, host)
  out(string.format("Done | teleported %s to host=%s", tostring(character_id), tostring(host)))
end

function ConsoleToolkit.teleport.companions_to_host()
  local host = GetHostCharacter()
  local teleported = 0

  for _, name in ipairs(ConsoleToolkit.constants.companion_names) do
    local id = ConsoleToolkit.constants.companion_uuids[name]
    if id ~= nil and id ~= host then
      Osi.TeleportTo(id, host)
      teleported = teleported + 1
      out(string.format("[OK] teleported %s (%s) to host=%s", name, tostring(id), tostring(host)))
    end
  end

  out(string.format("Done | teleported companions to host | host=%s | touched=%d", tostring(host), teleported))
end

out("ConsoleToolkit.teleport loaded. Run ConsoleToolkit.teleport.help()")

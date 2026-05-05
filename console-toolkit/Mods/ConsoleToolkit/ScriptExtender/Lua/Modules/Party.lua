-- Party and companion-state console helpers.

ConsoleToolkit = ConsoleToolkit or {}
ConsoleToolkit.modules = ConsoleToolkit.modules or {}
ConsoleToolkit.party = ConsoleToolkit.party or {}
ConsoleToolkit.modules.party = ConsoleToolkit.party

-- Short alias for Script Extender console calls through Mods.ConsoleToolkit.*.
party = ConsoleToolkit.party

local function out(msg)
  ConsoleToolkit.out(msg)
end

local function resolve_host(host_character_id)
  return host_character_id or GetHostCharacter()
end

function ConsoleToolkit.party.help()
  out("=== ConsoleToolkit.party Commands ===")
  out("Mods.ConsoleToolkit.party.fix_jaheira_party_member(<host_character_uuid>)")
  out("Tip: host_character_uuid defaults to GetHostCharacter().")
end

function ConsoleToolkit.party.fix_jaheira_party_member(host_character_id)
  local host = resolve_host(host_character_id)
  local jaheira = ConsoleToolkit.constants.companions.JAHEIRA

  Osi.PROC_GLO_PartyMembers_Remove(jaheira, host, 0)
  Osi.PROC_Hirelings_AddToParty(jaheira, host)

  out(string.format(
    "Done | refreshed Jaheira party-member state | jaheira=%s | host=%s",
    tostring(jaheira),
    tostring(host)
  ))
end

out("Mods.ConsoleToolkit.party loaded. Run Mods.ConsoleToolkit.party.help()")

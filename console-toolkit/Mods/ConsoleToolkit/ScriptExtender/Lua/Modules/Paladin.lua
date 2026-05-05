-- Paladin oath console helpers.

ConsoleToolkit = ConsoleToolkit or {}
ConsoleToolkit.modules = ConsoleToolkit.modules or {}
ConsoleToolkit.paladin = ConsoleToolkit.paladin or {}
ConsoleToolkit.modules.paladin = ConsoleToolkit.paladin

-- Short alias for Script Extender console calls through Mods.ConsoleToolkit.*.
paladin = ConsoleToolkit.paladin

local function out(msg)
  ConsoleToolkit.out(msg)
end

function ConsoleToolkit.paladin.help()
  out("=== ConsoleToolkit.paladin Commands ===")
  out("Mods.ConsoleToolkit.paladin.break_oath(<character_uuid>)")
  out("Mods.ConsoleToolkit.paladin.redeem_oath(<character_uuid>)")
  out("Tip: character_uuid defaults to GetHostCharacter().")
end

function ConsoleToolkit.paladin.break_oath(character_id)
  local target = ConsoleToolkit.utils.character_or_host(character_id)

  Osi.PROC_GLO_PaladinOathbreaker_BrokeOath(target)
  out(string.format("Done | broke paladin oath | target=%s", tostring(target)))
end

function ConsoleToolkit.paladin.redeem_oath(character_id)
  local target = ConsoleToolkit.utils.character_or_host(character_id)

  Osi.PROC_GLO_PaladinOathbreaker_RedemptionObtained(target)
  out(string.format("Done | redeemed paladin oath | target=%s", tostring(target)))
end

out("Mods.ConsoleToolkit.paladin loaded. Run Mods.ConsoleToolkit.paladin.help()")

-- Resource and currency console helpers.

ConsoleToolkit = ConsoleToolkit or {}
ConsoleToolkit.modules = ConsoleToolkit.modules or {}
ConsoleToolkit.resources = ConsoleToolkit.resources or {}
ConsoleToolkit.modules.resources = ConsoleToolkit.resources

-- Short alias for Script Extender console calls through Mods.ConsoleToolkit.*.
resources = ConsoleToolkit.resources

local function out(msg)
  ConsoleToolkit.out(msg)
end

function ConsoleToolkit.resources.help()
  out("=== ConsoleToolkit.resources Commands ===")
  out("ConsoleToolkit.resources.add_gold(<amount>, <character_uuid>)")
  out("ConsoleToolkit.resources.add_tadpoles(<amount>, <character_uuid>)")
  out("Tip: character_uuid defaults to GetHostCharacter(); gold amount defaults to 10000; tadpole amount defaults to 1.")
end

function ConsoleToolkit.resources.add_gold(amount, character_id)
  local target = ConsoleToolkit.utils.character_or_host(character_id)
  local value = ConsoleToolkit.utils.integer_or_default(amount, 10000)

  Osi.AddGold(target, value)
  out(string.format("Done | added gold=%d | target=%s", value, tostring(target)))
end

function ConsoleToolkit.resources.add_tadpoles(amount, character_id)
  local target = ConsoleToolkit.utils.character_or_host(character_id)
  local value = ConsoleToolkit.utils.integer_or_default(amount, 1)

  Osi.AddTadpole(target, value)
  out(string.format("Done | added tadpoles=%d | target=%s", value, tostring(target)))
end

out("ConsoleToolkit.resources loaded. Run ConsoleToolkit.resources.help()")

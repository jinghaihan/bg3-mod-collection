-- Character utility console helpers.

ConsoleToolkit = ConsoleToolkit or {}
ConsoleToolkit.modules = ConsoleToolkit.modules or {}
ConsoleToolkit.character = ConsoleToolkit.character or {}
ConsoleToolkit.modules.character = ConsoleToolkit.character

-- Short alias for Script Extender console calls through Mods.ConsoleToolkit.*.
character = ConsoleToolkit.character

local function out(msg)
  ConsoleToolkit.out(msg)
end

local function change_one_approval(companion_id, target, amount)
  Osi.ChangeApprovalRating(companion_id, target, 0, amount)
  out(string.format("[OK] changed approval=%d | companion=%s | target=%s", amount, tostring(companion_id), tostring(target)))
end

function ConsoleToolkit.character.help()
  out("=== ConsoleToolkit.character Commands ===")
  out("ConsoleToolkit.character.change_approval(<amount>, <companion_uuid>)")
  out("ConsoleToolkit.character.start_change_appearance(<character_uuid>)")
  out("ConsoleToolkit.character.start_respec(<character_uuid>)")
  out("Tip: change_approval amount defaults to 10; omit companion_uuid to apply to all constants.companions.")
  out("Tip: appearance/respec character_uuid defaults to GetHostCharacter().")
end

function ConsoleToolkit.character.change_approval(amount, companion_id)
  local target = GetHostCharacter()
  local value = ConsoleToolkit.utils.integer_or_default(amount, 10)

  if companion_id ~= nil then
    change_one_approval(companion_id, target, value)
    out(string.format("Done | changed approval for one companion | amount=%d | target=%s", value, tostring(target)))
    return
  end

  local changed = 0
  for _, name in ipairs(ConsoleToolkit.constants.companion_names) do
    local id = ConsoleToolkit.constants.companions[name]
    if id ~= nil then
      change_one_approval(id, target, value)
      changed = changed + 1
    end
  end

  out(string.format("Done | changed approval for all companions | amount=%d | target=%s | touched=%d", value, tostring(target), changed))
end

function ConsoleToolkit.character.start_change_appearance(character_id)
  local target = ConsoleToolkit.utils.character_or_host(character_id)

  Osi.StartChangeAppearance(target)
  out(string.format("Done | started change appearance | target=%s", tostring(target)))
end

function ConsoleToolkit.character.start_respec(character_id)
  local target = ConsoleToolkit.utils.character_or_host(character_id)

  Osi.StartRespec(target)
  out(string.format("Done | started respec | target=%s", tostring(target)))
end

out("ConsoleToolkit.character loaded. Run ConsoleToolkit.character.help()")

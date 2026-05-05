-- Status and crime-state console helpers.

ConsoleToolkit = ConsoleToolkit or {}
ConsoleToolkit.modules = ConsoleToolkit.modules or {}
ConsoleToolkit.status = ConsoleToolkit.status or {}
ConsoleToolkit.modules.status = ConsoleToolkit.status

-- Short alias for Script Extender console calls through Mods.ConsoleToolkit.*.
status = ConsoleToolkit.status

local function out(msg)
  ConsoleToolkit.out(msg)
end

function ConsoleToolkit.status.help()
  out("=== ConsoleToolkit.status Commands ===")
  out("Mods.ConsoleToolkit.status.remove_enemy_of_justice(<character_uuid>)")
  out("Mods.ConsoleToolkit.status.remove_enemy_of_justice_all_players()")
  out("Mods.ConsoleToolkit.status.knock_out_alfira(<source_character_uuid>)")
  out("Tip: character_uuid defaults to GetHostCharacter().")
end

local function suspend_guard_killer_crimes()
  local suspended = 0
  local rows = ConsoleToolkit.utils.safe_rows(function()
    return Osi.DB_CRIME_GuardKiller:Get(nil, nil, nil, nil, nil, nil, nil)
  end)

  for _, row in ipairs(rows) do
    local crime_id = row[7]
    if crime_id ~= nil then
      CrimeSuspend(crime_id)
      suspended = suspended + 1
      out(string.format("[OK] suspended guard-killer crime: %s", tostring(crime_id)))
    end
  end

  Osi.DB_CRIME_GuardKiller:Delete(nil, nil, nil, nil, nil, nil, nil)
  return suspended
end

local function remove_enemy_of_justice_status(character_id)
  Osi.RemoveStatus(character_id, "GB_GUARDKILLER")
end

function ConsoleToolkit.status.remove_enemy_of_justice(character_id)
  local target = character_id or GetHostCharacter()
  local suspended = suspend_guard_killer_crimes()
  remove_enemy_of_justice_status(target)

  out(string.format(
    "Done | removed GB_GUARDKILLER from %s | suspended_crimes=%d | cleared DB_CRIME_GuardKiller",
    tostring(target),
    suspended
  ))
end

function ConsoleToolkit.status.remove_enemy_of_justice_all_players()
  local ids = ConsoleToolkit.utils.player_ids()
  local suspended = suspend_guard_killer_crimes()
  out(string.format("Removing Enemy of Justice from DB_Players characters: %d", #ids))

  for _, id in ipairs(ids) do
    remove_enemy_of_justice_status(id)
    out(string.format("[OK] removed GB_GUARDKILLER from %s", tostring(id)))
  end

  out(string.format(
    "Done | removed GB_GUARDKILLER from all DB_Players characters | suspended_crimes=%d | cleared DB_CRIME_GuardKiller",
    suspended
  ))
end

function ConsoleToolkit.status.knock_out_alfira(source_character_id)
  local source = ConsoleToolkit.utils.character_or_host(source_character_id)
  local alfira = ConsoleToolkit.constants.npcs.ALFIRA

  ApplyStatus(alfira, "KNOCKED_OUT", -1, 1, source)
  out(string.format("Done | applied KNOCKED_OUT to Alfira | alfira=%s | source=%s", tostring(alfira), tostring(source)))
end

out("Mods.ConsoleToolkit.status loaded. Run Mods.ConsoleToolkit.status.help()")

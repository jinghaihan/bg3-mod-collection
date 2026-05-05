-- BG3 Script Extender console helpers for Background Inspiration goals.
--
-- This mod auto-loads this file via BootstrapServer.lua.
-- Then call from the Script Extender console:
-- Mods.ConsoleToolkit.inspiration.help()

ConsoleToolkit = ConsoleToolkit or {}
ConsoleToolkit.modules = ConsoleToolkit.modules or {}
ConsoleToolkit.inspiration = ConsoleToolkit.inspiration or {}
ConsoleToolkit.modules.inspiration = ConsoleToolkit.inspiration

-- Export module table for Script Extender console calls.
inspiration = ConsoleToolkit.inspiration

local function out(msg)
  ConsoleToolkit.out(msg)
end

local function background_tags_for_character(character_id)
  local tags = {}
  local rows = ConsoleToolkit.utils.safe_rows(function()
    return Osi.DB_GLO_Backgrounds_Players:Get(character_id, nil)
  end)
  for _, row in ipairs(rows) do
    tags[#tags + 1] = row[2]
  end
  return tags
end

local function completed_set_for_character(character_id)
  local set = {}
  local rows = ConsoleToolkit.utils.safe_rows(function()
    return Osi.DB_GLO_Backgrounds_Completed:Get(character_id, nil)
  end)
  for _, row in ipairs(rows) do
    set[row[2]] = true
  end
  return set
end

local function blocked_set()
  local set = {}
  local rows = ConsoleToolkit.utils.safe_rows(function()
    return Osi.DB_GLO_Backgrounds_Blocked:Get(nil)
  end)
  for _, row in ipairs(rows) do
    set[row[1]] = true
  end
  return set
end

local function all_background_goals()
  return ConsoleToolkit.utils.safe_rows(function()
    return Osi.DB_GLO_Backgrounds_Goal:Get(nil, nil, nil, nil)
  end)
end

local function blocked_goals_all()
  local result = {}
  local blocked = blocked_set()
  for _, row in ipairs(all_background_goals()) do
    local bg_tag = row[1]
    local goal_string = row[2]
    local goal_uuid = row[3]
    local scope = row[4]
    if blocked[goal_string] then
      result[#result + 1] = {
        background_tag = bg_tag,
        goal_string = goal_string,
        goal_uuid = goal_uuid,
        scope = scope,
      }
    end
  end

  table.sort(result, function(a, b)
    return a.goal_string < b.goal_string
  end)
  return result
end

local function blocked_goals_for_character(character_id)
  local result = {}
  local tags = background_tags_for_character(character_id)
  local tag_set = {}
  for _, tag in ipairs(tags) do
    tag_set[tag] = true
  end

  local blocked = blocked_set()
  for _, row in ipairs(all_background_goals()) do
    local bg_tag = row[1]
    local goal_string = row[2]
    local goal_uuid = row[3]
    local scope = row[4]
    if tag_set[bg_tag] and blocked[goal_string] then
      result[#result + 1] = {
        background_tag = bg_tag,
        goal_string = goal_string,
        goal_uuid = goal_uuid,
        scope = scope,
      }
    end
  end

  table.sort(result, function(a, b)
    return a.goal_string < b.goal_string
  end)
  return result
end

local function missing_goals_for_character(character_id, ignore_blocked)
  local result = {}
  local tags = background_tags_for_character(character_id)
  local tag_set = {}
  for _, tag in ipairs(tags) do
    tag_set[tag] = true
  end

  local completed = completed_set_for_character(character_id)
  local blocked = {}
  if not ignore_blocked then
    blocked = blocked_set()
  end

  for _, row in ipairs(all_background_goals()) do
    local bg_tag = row[1]
    local goal_string = row[2]
    local goal_uuid = row[3]
    local scope = row[4]

    if tag_set[bg_tag] and (not completed[goal_string]) and (not blocked[goal_string]) then
      result[#result + 1] = {
        background_tag = bg_tag,
        goal_string = goal_string,
        goal_uuid = goal_uuid,
        scope = scope,
      }
    end
  end

  table.sort(result, function(a, b)
    return a.goal_string < b.goal_string
  end)

  return result
end

function ConsoleToolkit.inspiration.help()
  out("=== ConsoleToolkit.inspiration Commands ===")
  out("Mods.ConsoleToolkit.inspiration.dump_all_goals()")
  out("Mods.ConsoleToolkit.inspiration.dump_blocked_all()")
  out("Mods.ConsoleToolkit.inspiration.dump_players()")
  out("Mods.ConsoleToolkit.inspiration.dump_missing(<character_uuid>)")
  out("Mods.ConsoleToolkit.inspiration.dump_missing_ignore_blocked(<character_uuid>)")
  out("Mods.ConsoleToolkit.inspiration.dump_blocked(<character_uuid>)")
  out("Mods.ConsoleToolkit.inspiration.dump_missing_all_players()")
  out("Mods.ConsoleToolkit.inspiration.dump_blocked_all_players()")
  out("Mods.ConsoleToolkit.inspiration.print_missing_grants(<character_uuid>, <max_count>)")
  out("Mods.ConsoleToolkit.inspiration.print_missing_grants_ignore_blocked(<character_uuid>, <max_count>)")
  out("Mods.ConsoleToolkit.inspiration.print_missing_grants_all_players(<max_count_per_player>)")
  out("Mods.ConsoleToolkit.inspiration.print_missing_grants_ignore_blocked_all_players(<max_count_per_player>)")
  out("Mods.ConsoleToolkit.inspiration.grant_missing(<character_uuid>, <max_count>)")
  out("Mods.ConsoleToolkit.inspiration.grant_missing_ignore_blocked(<character_uuid>, <max_count>)")
  out("Mods.ConsoleToolkit.inspiration.grant_missing_all_players(<max_count_per_player>)")
  out("Mods.ConsoleToolkit.inspiration.grant_missing_ignore_blocked_all_players(<max_count_per_player>)")
  out("Mods.ConsoleToolkit.inspiration.dump_all_goals_csv()")
  out("Tip: print_missing_grants* only prints; grant_missing* actually calls the game API.")
end

function ConsoleToolkit.inspiration.dump_all_goals()
  local rows = all_background_goals()
  out(string.format("Total DB_GLO_Backgrounds_Goal rows: %d", #rows))
  for i, row in ipairs(rows) do
    out(string.format(
      "%04d | bgTag=%s | goalString=%s | goalUUID=%s | scope=%s",
      i,
      tostring(row[1]),
      tostring(row[2]),
      tostring(row[3]),
      tostring(row[4])
    ))
  end
end

function ConsoleToolkit.inspiration.dump_blocked_all()
  local rows = blocked_goals_all()
  out(string.format("Blocked goals in DB_GLO_Backgrounds_Blocked: %d", #rows))
  for i, item in ipairs(rows) do
    out(string.format(
      "%03d | bgTag=%s | goalString=%s | goalUUID=%s | scope=%s",
      i,
      tostring(item.background_tag),
      tostring(item.goal_string),
      tostring(item.goal_uuid),
      tostring(item.scope)
    ))
  end
end

function ConsoleToolkit.inspiration.dump_all_goals_csv()
  local rows = all_background_goals()
  out("background_tag,goal_string,goal_uuid,scope")
  for _, row in ipairs(rows) do
    out(string.format(
      "%s,%s,%s,%s",
      tostring(row[1]),
      tostring(row[2]),
      tostring(row[3]),
      tostring(row[4])
    ))
  end
end

function ConsoleToolkit.inspiration.dump_players()
  local ids = ConsoleToolkit.utils.player_ids()
  out(string.format("Total DB_Players rows: %d", #ids))
  for i, id in ipairs(ids) do
    out(string.format("%02d | %s", i, tostring(id)))
  end
end

function ConsoleToolkit.inspiration.dump_missing(character_id)
  local missing = missing_goals_for_character(character_id)
  out(string.format("Missing goals for %s: %d", tostring(character_id), #missing))
  for i, item in ipairs(missing) do
    out(string.format(
      "%03d | bgTag=%s | goalString=%s | goalUUID=%s | scope=%s",
      i,
      tostring(item.background_tag),
      tostring(item.goal_string),
      tostring(item.goal_uuid),
      tostring(item.scope)
    ))
  end
end

function ConsoleToolkit.inspiration.dump_missing_ignore_blocked(character_id)
  local missing = missing_goals_for_character(character_id, true)
  out(string.format("Missing goals for %s, ignoring blocked state: %d", tostring(character_id), #missing))
  for i, item in ipairs(missing) do
    out(string.format(
      "%03d | bgTag=%s | goalString=%s | goalUUID=%s | scope=%s",
      i,
      tostring(item.background_tag),
      tostring(item.goal_string),
      tostring(item.goal_uuid),
      tostring(item.scope)
    ))
  end
end

function ConsoleToolkit.inspiration.dump_blocked(character_id)
  local rows = blocked_goals_for_character(character_id)
  out(string.format("Blocked goals for %s: %d", tostring(character_id), #rows))
  for i, item in ipairs(rows) do
    out(string.format(
      "%03d | bgTag=%s | goalString=%s | goalUUID=%s | scope=%s",
      i,
      tostring(item.background_tag),
      tostring(item.goal_string),
      tostring(item.goal_uuid),
      tostring(item.scope)
    ))
  end
end

function ConsoleToolkit.inspiration.dump_missing_all_players()
  for _, id in ipairs(ConsoleToolkit.utils.player_ids()) do
    ConsoleToolkit.inspiration.dump_missing(id)
  end
end

function ConsoleToolkit.inspiration.dump_blocked_all_players()
  for _, id in ipairs(ConsoleToolkit.utils.player_ids()) do
    ConsoleToolkit.inspiration.dump_blocked(id)
  end
end

local function print_grants_for_character(character_id, ignore_blocked, max_count)
  if max_count == nil then
    max_count = 999999
  end

  local missing = missing_goals_for_character(character_id, ignore_blocked)
  local printed = 0

  for _, item in ipairs(missing) do
    if printed >= max_count then
      break
    end

    if ignore_blocked then
      out(string.format("[PRINT][IGNORE_BLOCKED] would grant %s to %s", item.goal_string, tostring(character_id)))
    else
      out(string.format("[PRINT] would grant %s to %s", item.goal_string, tostring(character_id)))
    end

    printed = printed + 1
  end

  out(string.format(
    "Printed for %s | ignore_blocked=%s | count=%d",
    tostring(character_id),
    tostring(ignore_blocked),
    printed
  ))
end

local function grant_goals_for_character(character_id, ignore_blocked, max_count)
  if max_count == nil then
    max_count = 999999
  end

  local missing = missing_goals_for_character(character_id, ignore_blocked)
  local granted = 0

  for _, item in ipairs(missing) do
    if granted >= max_count then
      break
    end

    Osi.PROC_GLO_Backgrounds_CompleteGoal(character_id, item.goal_string)

    if ignore_blocked then
      out(string.format("[OK][IGNORE_BLOCKED] granted %s to %s", item.goal_string, tostring(character_id)))
    else
      out(string.format("[OK] granted %s to %s", item.goal_string, tostring(character_id)))
    end

    granted = granted + 1
  end

  out(string.format(
    "Done for %s | ignore_blocked=%s | granted=%d",
    tostring(character_id),
    tostring(ignore_blocked),
    granted
  ))
end

function ConsoleToolkit.inspiration.print_missing_grants(character_id, max_count)
  print_grants_for_character(character_id, false, max_count)
end

function ConsoleToolkit.inspiration.print_missing_grants_ignore_blocked(character_id, max_count)
  print_grants_for_character(character_id, true, max_count)
end

function ConsoleToolkit.inspiration.print_missing_grants_all_players(max_count_per_player)
  for _, id in ipairs(ConsoleToolkit.utils.player_ids()) do
    ConsoleToolkit.inspiration.print_missing_grants(id, max_count_per_player)
  end
end

function ConsoleToolkit.inspiration.print_missing_grants_ignore_blocked_all_players(max_count_per_player)
  for _, id in ipairs(ConsoleToolkit.utils.player_ids()) do
    ConsoleToolkit.inspiration.print_missing_grants_ignore_blocked(id, max_count_per_player)
  end
end

function ConsoleToolkit.inspiration.grant_missing(character_id, max_count)
  grant_goals_for_character(character_id, false, max_count)
end

function ConsoleToolkit.inspiration.grant_missing_ignore_blocked(character_id, max_count)
  grant_goals_for_character(character_id, true, max_count)
end

function ConsoleToolkit.inspiration.grant_missing_all_players(max_count_per_player)
  for _, id in ipairs(ConsoleToolkit.utils.player_ids()) do
    ConsoleToolkit.inspiration.grant_missing(id, max_count_per_player)
  end
end

function ConsoleToolkit.inspiration.grant_missing_ignore_blocked_all_players(max_count_per_player)
  for _, id in ipairs(ConsoleToolkit.utils.player_ids()) do
    ConsoleToolkit.inspiration.grant_missing_ignore_blocked(id, max_count_per_player)
  end
end


out("Mods.ConsoleToolkit.inspiration loaded. Run Mods.ConsoleToolkit.inspiration.help()")

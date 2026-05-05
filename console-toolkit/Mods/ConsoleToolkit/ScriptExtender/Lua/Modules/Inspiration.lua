-- BG3 Script Extender console helpers for Background Inspiration goals.
--
-- This mod auto-loads this file via BootstrapServer.lua.
-- Then call from the Script Extender console:
-- ConsoleToolkit.inspiration.help()

ConsoleToolkit = ConsoleToolkit or {}
ConsoleToolkit.modules = ConsoleToolkit.modules or {}
ConsoleToolkit.inspiration = ConsoleToolkit.inspiration or {}
ConsoleToolkit.modules.inspiration = ConsoleToolkit.inspiration

-- Short aliases for Script Extender console calls through Mods.ConsoleToolkit.*.
inspiration = ConsoleToolkit.inspiration
InspirationConsole = ConsoleToolkit.inspiration

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
  out("ConsoleToolkit.inspiration.dump_all_goals()")
  out("ConsoleToolkit.inspiration.dump_blocked_all()")
  out("ConsoleToolkit.inspiration.dump_players()")
  out("ConsoleToolkit.inspiration.dump_missing(<character_uuid>)")
  out("ConsoleToolkit.inspiration.dump_missing_ignore_blocked(<character_uuid>)")
  out("ConsoleToolkit.inspiration.dump_blocked(<character_uuid>)")
  out("ConsoleToolkit.inspiration.dump_missing_all_players()")
  out("ConsoleToolkit.inspiration.dump_blocked_all_players()")
  out("ConsoleToolkit.inspiration.grant_missing(<character_uuid>, <dry_run>, <max_count>)")
  out("ConsoleToolkit.inspiration.grant_missing_ignore_blocked(<character_uuid>, <dry_run>, <max_count>)")
  out("ConsoleToolkit.inspiration.grant_missing_all_players(<dry_run>, <max_count_per_player>)")
  out("ConsoleToolkit.inspiration.grant_missing_ignore_blocked_all_players(<dry_run>, <max_count_per_player>)")
  out("ConsoleToolkit.inspiration.dump_all_goals_csv()")
  out("Tip: dry_run defaults to true. Pass false to actually grant goals.")
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

function ConsoleToolkit.inspiration.grant_missing(character_id, dry_run, max_count)
  if dry_run == nil then
    dry_run = true
  end
  if max_count == nil then
    max_count = 999999
  end

  local missing = missing_goals_for_character(character_id)
  local granted = 0

  for _, item in ipairs(missing) do
    if granted >= max_count then
      break
    end

    if dry_run then
      out(string.format("[DRY] would grant %s to %s", item.goal_string, tostring(character_id)))
    else
      Osi.PROC_GLO_Backgrounds_CompleteGoal(character_id, item.goal_string)
      out(string.format("[OK] granted %s to %s", item.goal_string, tostring(character_id)))
    end

    granted = granted + 1
  end

  out(string.format(
    "Done for %s | dry_run=%s | touched=%d",
    tostring(character_id),
    tostring(dry_run),
    granted
  ))
end

function ConsoleToolkit.inspiration.grant_missing_ignore_blocked(character_id, dry_run, max_count)
  if dry_run == nil then
    dry_run = true
  end
  if max_count == nil then
    max_count = 999999
  end

  local missing = missing_goals_for_character(character_id, true)
  local granted = 0

  for _, item in ipairs(missing) do
    if granted >= max_count then
      break
    end

    if dry_run then
      out(string.format("[DRY][IGNORE_BLOCKED] would grant %s to %s", item.goal_string, tostring(character_id)))
    else
      Osi.PROC_GLO_Backgrounds_CompleteGoal(character_id, item.goal_string)
      out(string.format("[OK][IGNORE_BLOCKED] granted %s to %s", item.goal_string, tostring(character_id)))
    end

    granted = granted + 1
  end

  out(string.format(
    "Done for %s | dry_run=%s | ignore_blocked=true | touched=%d",
    tostring(character_id),
    tostring(dry_run),
    granted
  ))
end

function ConsoleToolkit.inspiration.grant_missing_all_players(dry_run, max_count_per_player)
  for _, id in ipairs(ConsoleToolkit.utils.player_ids()) do
    ConsoleToolkit.inspiration.grant_missing(id, dry_run, max_count_per_player)
  end
end

function ConsoleToolkit.inspiration.grant_missing_ignore_blocked_all_players(dry_run, max_count_per_player)
  for _, id in ipairs(ConsoleToolkit.utils.player_ids()) do
    ConsoleToolkit.inspiration.grant_missing_ignore_blocked(id, dry_run, max_count_per_player)
  end
end

out("ConsoleToolkit.inspiration loaded. Run ConsoleToolkit.inspiration.help()")

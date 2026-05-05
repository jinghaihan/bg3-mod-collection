-- Shared helpers for ConsoleToolkit modules.

ConsoleToolkit = ConsoleToolkit or {}
ConsoleToolkit.utils = ConsoleToolkit.utils or {}

function ConsoleToolkit.utils.safe_rows(db_get)
  local ok, rows = pcall(db_get)
  if ok and rows then
    return rows
  end
  return {}
end

function ConsoleToolkit.utils.player_ids()
  local ids = {}
  local rows = ConsoleToolkit.utils.safe_rows(function()
    return Osi.DB_Players:Get(nil)
  end)

  for _, row in ipairs(rows) do
    ids[#ids + 1] = row[1]
  end

  return ids
end

function ConsoleToolkit.utils.number_or_default(value, default_value)
  local number = tonumber(value)
  if number == nil then
    return default_value
  end
  return number
end

function ConsoleToolkit.utils.integer_or_default(value, default_value)
  local number = ConsoleToolkit.utils.number_or_default(value, default_value)
  return math.floor(number)
end

function ConsoleToolkit.utils.character_or_host(character_id)
  return character_id or GetHostCharacter()
end

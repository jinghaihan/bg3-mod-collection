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

-- Trade utility console helpers.

ConsoleToolkit = ConsoleToolkit or {}
ConsoleToolkit.modules = ConsoleToolkit.modules or {}
ConsoleToolkit.trade = ConsoleToolkit.trade or {}
ConsoleToolkit.modules.trade = ConsoleToolkit.trade

-- Short alias for Script Extender console calls through Mods.ConsoleToolkit.*.
trade = ConsoleToolkit.trade

local TRADER_TAG = "91d5ebc6-91ea-44db-8a51-216860d69b5b"

local function out(msg)
  ConsoleToolkit.out(msg)
end

local function set_attitude(trader_id, player_id, value)
  local current = Osi.GetAttitudeTowardsPlayer(trader_id, player_id)
  local delta = value - current

  if delta ~= 0 then
    Osi.AddAttitudeTowardsPlayer(trader_id, player_id, delta)
  end

  out(string.format(
    "[OK] set trader attitude=%d | trader=%s | player=%s",
    value,
    tostring(trader_id),
    tostring(player_id)
  ))
end

local function loaded_trader_ids()
  local ids = {}

  for _, entity in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerCharacter")) do
    local id = Ext.Entity.HandleToUuid(entity)
    if id ~= nil and Osi.IsTagged(id, TRADER_TAG, 1) == 1 then
      ids[#ids + 1] = id
    end
  end

  return ids
end

function ConsoleToolkit.trade.help()
  out("=== ConsoleToolkit.trade Commands ===")
  out("Mods.ConsoleToolkit.trade.get_loaded_trader_ids()")
  out("Mods.ConsoleToolkit.trade.list_loaded_traders()")
  out("Mods.ConsoleToolkit.trade.max_loaded_trader_attitude()")
  out("Tip: this only affects currently loaded characters with the TRADER tag.")
end

function ConsoleToolkit.trade.get_loaded_trader_ids()
  return loaded_trader_ids()
end

function ConsoleToolkit.trade.list_loaded_traders()
  local traders = loaded_trader_ids()
  local players = ConsoleToolkit.utils.player_ids()

  out(string.format("Loaded traders: %d | DB_Players avatars: %d", #traders, #players))

  for _, trader_id in ipairs(traders) do
    out(string.format("Trader | id=%s", tostring(trader_id)))

    for _, player_id in ipairs(players) do
      local attitude = Osi.GetAttitudeTowardsPlayer(trader_id, player_id)
      out(string.format("  attitude=%d | player=%s", attitude, tostring(player_id)))
    end
  end

  return traders
end

function ConsoleToolkit.trade.max_loaded_trader_attitude()
  local traders = loaded_trader_ids()
  local players = ConsoleToolkit.utils.player_ids()
  local touched = 0

  for _, trader_id in ipairs(traders) do
    for _, player_id in ipairs(players) do
      set_attitude(trader_id, player_id, 100)
      touched = touched + 1
    end
  end

  out(string.format(
    "Done | maxed loaded trader attitude | traders=%d | players=%d | touched=%d",
    #traders,
    #players,
    touched
  ))
end

out("Mods.ConsoleToolkit.trade loaded. Run Mods.ConsoleToolkit.trade.help()")

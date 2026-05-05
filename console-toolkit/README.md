# Console Toolkit

BG3 mod project containing `ConsoleToolkit`, a modular Script Extender console toolkit.

The goal is to keep reusable console utilities in one mod instead of creating a separate tiny Script Extender mod for every task. Each feature area lives in its own Lua module under `Mods/ConsoleToolkit/ScriptExtender/Lua/Modules/`.

## Layout

- `Mods/ConsoleToolkit/`: the mod package.
- `Mods/ConsoleToolkit/ScriptExtender/Lua/ConsoleToolkit.lua`: shared bootstrap and top-level helper commands.
- `Mods/ConsoleToolkit/ScriptExtender/Lua/Constants.lua`: shared UUID constants for companion helpers.
- `Mods/ConsoleToolkit/ScriptExtender/Lua/Modules/Inspiration.lua`: background inspiration helper module.
- `Mods/ConsoleToolkit/ScriptExtender/Lua/Modules/Status.lua`: status and crime-state helper module.
- `Mods/ConsoleToolkit/ScriptExtender/Lua/Modules/Items.lua`: item and equipment helper module.
- `Mods/ConsoleToolkit/ScriptExtender/Lua/Modules/Party.lua`: party and companion-state helper module.
- `Public/ConsoleToolkit/Stats/Generated/Data/Armor.txt`: camp clothing stat entries used by the item module.
- `inspiration_goals.csv`: full inspiration goal list snapshot, sorted by background.

## Console Usage

Use the Script Extender console in `server` context:

```lua
server

-- show all top-level modules
Mods.ConsoleToolkit.help()

-- show inspiration module commands
Mods.ConsoleToolkit.inspiration.help()

-- show status module commands
Mods.ConsoleToolkit.status.help()

-- show item module commands
Mods.ConsoleToolkit.items.help()

-- show party module commands
Mods.ConsoleToolkit.party.help()
```

You can also call the global table directly:

```lua
server

ConsoleToolkit.help()
ConsoleToolkit.inspiration.help()
ConsoleToolkit.status.help()
ConsoleToolkit.items.help()
ConsoleToolkit.party.help()
```

## Inspiration Module

`ConsoleToolkit.inspiration` provides utilities for inspecting and granting background inspiration goals.

```lua
server

-- print all goal definitions from DB_GLO_Backgrounds_Goal
Mods.ConsoleToolkit.inspiration.dump_all_goals()

-- print all goal definitions as CSV lines in console
Mods.ConsoleToolkit.inspiration.dump_all_goals_csv()

-- print all currently blocked goals, mapped to goal details
Mods.ConsoleToolkit.inspiration.dump_blocked_all()

-- list all player character IDs from DB_Players
Mods.ConsoleToolkit.inspiration.dump_players()

-- print missing grantable goals for one character ID
Mods.ConsoleToolkit.inspiration.dump_missing("<character_uuid>")

-- print missing goals for one character ID, including goals currently marked blocked
Mods.ConsoleToolkit.inspiration.dump_missing_ignore_blocked("<character_uuid>")

-- print blocked goals for one character ID, filtered by that character's background
Mods.ConsoleToolkit.inspiration.dump_blocked("<character_uuid>")

-- print missing grantable goals for every player character
Mods.ConsoleToolkit.inspiration.dump_missing_all_players()

-- print blocked goals for every player character
Mods.ConsoleToolkit.inspiration.dump_blocked_all_players()

-- dry run: show what would be granted for one character, no actual grant
Mods.ConsoleToolkit.inspiration.grant_missing("<character_uuid>", true, 999999)

-- real grant for one character, optionally cap number of grants
Mods.ConsoleToolkit.inspiration.grant_missing("<character_uuid>", false, 999999)

-- dry run: show what would be granted while ignoring blocked state
Mods.ConsoleToolkit.inspiration.grant_missing_ignore_blocked("<character_uuid>", true, 999999)

-- real grant while ignoring blocked state
Mods.ConsoleToolkit.inspiration.grant_missing_ignore_blocked("<character_uuid>", false, 999999)

-- dry run: show grants for all players, no actual grant
Mods.ConsoleToolkit.inspiration.grant_missing_all_players(true)

-- real grant for all players
Mods.ConsoleToolkit.inspiration.grant_missing_all_players(false)

-- real grant for all players while ignoring blocked state
Mods.ConsoleToolkit.inspiration.grant_missing_ignore_blocked_all_players(false)
```

For compatibility with the old mod name, `InspirationConsole` is still available as an alias for `ConsoleToolkit.inspiration`.

```lua
server

InspirationConsole.help()
InspirationConsole.dump_all_goals()
```

## Native Osiris API

If you already know the exact `goal_string` from `inspiration_goals.csv`, you can call the game API directly in the Script Extender `server` console:

```lua
server

local goal_string = "Act1_Soldier_PleaAtGates"
Osi.PROC_GLO_Backgrounds_CompleteGoal(GetHostCharacter(), goal_string)
```

`GetHostCharacter()` targets the host/player character. Replace it with another character UUID if you want to grant the inspiration goal to a specific character.

## Status Module

`ConsoleToolkit.status` provides manual status and crime-state cleanup helpers. These functions do not register automatic listeners; they only run when you call them from the Script Extender console.

```lua
server

-- remove Enemy of Justice from the host character, suspend guard-killer crimes,
-- and clear DB_CRIME_GuardKiller records
Mods.ConsoleToolkit.status.remove_enemy_of_justice()

-- same cleanup, but target a specific character ID for the status removal
Mods.ConsoleToolkit.status.remove_enemy_of_justice("<character_uuid>")

-- remove Enemy of Justice from every character listed in DB_Players,
-- while suspending and clearing guard-killer crime records once
Mods.ConsoleToolkit.status.remove_enemy_of_justice_all_players()
```

## Items Module

`ConsoleToolkit.items` provides manual item and equipment grant helpers. These functions add items directly to the target character and do not use the Tutorial Chest.

```lua
server

-- add the prologue companion camp clothing set to the host character
Mods.ConsoleToolkit.items.grant_prologue_camp_clothing()

-- add the epilogue companion camp clothing set to the host character
Mods.ConsoleToolkit.items.grant_epilogue_camp_clothing()

-- add the digital deluxe clothing set to the host character
Mods.ConsoleToolkit.items.grant_digital_deluxe_clothing()

-- alias for the same DLC_TWITCH_* clothing set
Mods.ConsoleToolkit.items.grant_twitch_clothing()

-- dry run for a specific character
Mods.ConsoleToolkit.items.grant_prologue_camp_clothing("<character_uuid>", true)
Mods.ConsoleToolkit.items.grant_epilogue_camp_clothing("<character_uuid>", true)
Mods.ConsoleToolkit.items.grant_digital_deluxe_clothing("<character_uuid>", true)

-- real grant for a specific character
Mods.ConsoleToolkit.items.grant_prologue_camp_clothing("<character_uuid>", false)
Mods.ConsoleToolkit.items.grant_epilogue_camp_clothing("<character_uuid>", false)
Mods.ConsoleToolkit.items.grant_digital_deluxe_clothing("<character_uuid>", false)
```

The prologue set uses original game item templates directly. The epilogue and digital deluxe sets use the armor stat entries copied from the companion camp outfit data; this module does not include the old custom backpack objects or any `TUT_Chest_Potions` treasure-table merge.

## Party Module

`ConsoleToolkit.party` provides manual fixes for party and companion state bugs.

```lua
server

-- refresh Jaheira's party-member state so she is treated as a real party member
-- for auto-combat joining and party-targeted buffs
Mods.ConsoleToolkit.party.fix_jaheira_party_member()

-- same fix, but with an explicit host character ID
Mods.ConsoleToolkit.party.fix_jaheira_party_member("<host_character_uuid>")
```

This function runs the same two Osiris calls manually:

```lua
server

local jaheira = Mods.ConsoleToolkit.constants.companions.JAHEIRA
local host = GetHostCharacter()
Osi.PROC_GLO_PartyMembers_Remove(jaheira, host, 0)
Osi.PROC_Hirelings_AddToParty(jaheira, host)
```

## Background Summary

| Background | Goal Count |
|---|---:|
| ACOLYTE | 44 |
| CHARLATAN | 43 |
| CRIMINAL | 46 |
| ENTERTAINER | 42 |
| FOLKHERO | 43 |
| GUILD_ARTISAN | 44 |
| HAUNTED_ONE | 56 |
| NOBLE | 43 |
| OUTLANDER | 44 |
| SAGE | 47 |
| SOLDIER | 43 |
| URCHIN | 44 |

## Notes

- `grant_missing_*` checks background match and skips completed/blocked goals.
- `grant_missing_ignore_blocked*` checks background match and skips completed goals, but does not skip goals in `DB_GLO_Backgrounds_Blocked`.
- Start with `dry_run=true` before real grants.
- The checked-in source has been renamed to `ConsoleToolkit`; build a fresh `.pak` before installing if you need a packed release.

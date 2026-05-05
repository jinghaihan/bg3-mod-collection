# inspiration-console-tools

BG3 mod project containing `InspirationConsoleTools`, a Script Extender console helper for:

- listing runtime background inspiration goals,
- finding missing goals per character,
- optionally granting missing goals safely via Osiris,
- optionally ignoring the global blocked-goal list when granting goals.

## Layout

- `Mods/InspirationConsoleTools/`: the mod package.
- `inspiration_goals.csv`: full goal list snapshot (sorted by background).

## Console usage

Use Script Extender console in `server` context:

```lua
server

# show all available commands
Mods.InspirationConsoleTools.InspirationConsole.help()

# print all goal definitions from DB_GLO_Backgrounds_Goal
Mods.InspirationConsoleTools.InspirationConsole.dump_all_goals()

# print all goal definitions as CSV lines in console
Mods.InspirationConsoleTools.InspirationConsole.dump_all_goals_csv()

# print all currently blocked goals (global blocked list mapped to goal details)
Mods.InspirationConsoleTools.InspirationConsole.dump_blocked_all()

# list all player character IDs from DB_Players
Mods.InspirationConsoleTools.InspirationConsole.dump_players()

# print missing (grantable) goals for one character ID
Mods.InspirationConsoleTools.InspirationConsole.dump_missing("<character_uuid>")

# print missing goals for one character ID, including goals currently marked blocked
Mods.InspirationConsoleTools.InspirationConsole.dump_missing_ignore_blocked("<character_uuid>")

# print blocked goals for one character ID (background-matched + blocked)
Mods.InspirationConsoleTools.InspirationConsole.dump_blocked("<character_uuid>")

# print missing (grantable) goals for every player character
Mods.InspirationConsoleTools.InspirationConsole.dump_missing_all_players()

# print blocked goals for every player character
Mods.InspirationConsoleTools.InspirationConsole.dump_blocked_all_players()

# dry run: show what would be granted for one character, no actual grant
Mods.InspirationConsoleTools.InspirationConsole.grant_missing("<character_uuid>", true, 999999)

# real grant for one character, optionally cap number of grants
Mods.InspirationConsoleTools.InspirationConsole.grant_missing("<character_uuid>", false, 999999)

# dry run: show what would be granted while ignoring blocked state
Mods.InspirationConsoleTools.InspirationConsole.grant_missing_ignore_blocked("<character_uuid>", true, 999999)

# real grant while ignoring blocked state
Mods.InspirationConsoleTools.InspirationConsole.grant_missing_ignore_blocked("<character_uuid>", false, 999999)

# dry run: show grants for all players, no actual grant
Mods.InspirationConsoleTools.InspirationConsole.grant_missing_all_players(true)

# real grant for all players
Mods.InspirationConsoleTools.InspirationConsole.grant_missing_all_players(false)

# real grant for all players while ignoring blocked state
Mods.InspirationConsoleTools.InspirationConsole.grant_missing_ignore_blocked_all_players(false)
```

## Native Osiris API

If you already know the exact `goal_string` from `inspiration_goals.csv`, you can call the game API directly in the Script Extender `server` console:

```lua
server

local goal_string = "Act1_Soldier_PleaAtGates"
Osi.PROC_GLO_Backgrounds_CompleteGoal(GetHostCharacter(), goal_string)
```

`GetHostCharacter()` targets the host/player character. Replace it with another character UUID if you want to grant the inspiration goal to a specific character.

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

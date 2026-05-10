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
- `Mods/ConsoleToolkit/ScriptExtender/Lua/Modules/Resources.lua`: gold and tadpole helper module.
- `Mods/ConsoleToolkit/ScriptExtender/Lua/Modules/Character.lua`: approval, appearance, and respec helper module.
- `Mods/ConsoleToolkit/ScriptExtender/Lua/Modules/Teleport.lua`: teleport helper module.
- `Mods/ConsoleToolkit/ScriptExtender/Lua/Modules/Paladin.lua`: paladin oath helper module.
- `Public/ConsoleToolkit/Stats/Generated/Data/Armor.txt`: camp clothing stat entries used by the item module.
- `Public/ConsoleToolkit/Stats/Generated/Data/Object.txt`: extra object stat entries used by the item module.
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

-- show resource, character, teleport, and paladin helper commands
Mods.ConsoleToolkit.resources.help()
Mods.ConsoleToolkit.character.help()
Mods.ConsoleToolkit.teleport.help()
Mods.ConsoleToolkit.paladin.help()
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

-- preview what would be granted for one character, no actual grant
Mods.ConsoleToolkit.inspiration.print_missing_grants("<character_uuid>", 999999)

-- real grant for one character, optionally cap number of grants
Mods.ConsoleToolkit.inspiration.grant_missing("<character_uuid>", 999999)

-- preview what would be granted while ignoring blocked state
Mods.ConsoleToolkit.inspiration.print_missing_grants_ignore_blocked("<character_uuid>", 999999)

-- complete one exact goal for one character
Mods.ConsoleToolkit.inspiration.complete_goal("<character_uuid>", "Act1_Sage_GaleResurrection")

-- complete one exact goal after removing its blocked DB row if needed
Mods.ConsoleToolkit.inspiration.complete_goal_ignore_blocked("<character_uuid>", "Act1_Sage_GaleResurrection")

-- real grant while ignoring blocked state
Mods.ConsoleToolkit.inspiration.grant_missing_ignore_blocked("<character_uuid>", 999999)

-- preview grants for all players, no actual grant
Mods.ConsoleToolkit.inspiration.print_missing_grants_all_players()

-- real grant for all players
Mods.ConsoleToolkit.inspiration.grant_missing_all_players()

-- real grant for all players while ignoring blocked state
Mods.ConsoleToolkit.inspiration.grant_missing_ignore_blocked_all_players()
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

-- apply KNOCKED_OUT to Alfira, using the host character as the source
Mods.ConsoleToolkit.status.knock_out_alfira()
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

-- add one of every collected scroll to the host character
Mods.ConsoleToolkit.items.grant_scrolls()

-- add 50 of every collected arrow to the host character
Mods.ConsoleToolkit.items.grant_arrows()

-- add 10 of every collected dye and 20 dye removers to the host character
Mods.ConsoleToolkit.items.grant_dyes()

-- custom quantities
Mods.ConsoleToolkit.items.grant_scrolls(3)
Mods.ConsoleToolkit.items.grant_arrows(100)
Mods.ConsoleToolkit.items.grant_dyes(20, 40)
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

## Resources Module

`ConsoleToolkit.resources` provides thin wrappers around resource-related Osiris APIs.

```lua
server

-- add 10000 gold to the host character
Mods.ConsoleToolkit.resources.add_gold()

-- add a custom amount of gold to the host character
Mods.ConsoleToolkit.resources.add_gold(50000)

-- add one tadpole to the host character
Mods.ConsoleToolkit.resources.add_tadpoles()

-- add a custom amount of tadpoles to the host character
Mods.ConsoleToolkit.resources.add_tadpoles(5)
```

## Character Module

`ConsoleToolkit.character` provides thin wrappers for approval, appearance, and respec actions.

```lua
server

-- add 10 approval with every companion constant toward the host character
Mods.ConsoleToolkit.character.change_approval()

-- add 100 approval with every companion constant toward the host character
Mods.ConsoleToolkit.character.change_approval(100)

-- add 10 approval with one specific companion toward the host character
Mods.ConsoleToolkit.character.change_approval(10, Mods.ConsoleToolkit.constants.companions.SHADOWHEART)

-- open the change appearance flow for the host character
Mods.ConsoleToolkit.character.start_change_appearance()

-- open the respec flow for the host character
Mods.ConsoleToolkit.character.start_respec()

-- remove or restore the half-illithid appearance on the host character
Mods.ConsoleToolkit.character.remove_half_illithid_appearance()
Mods.ConsoleToolkit.character.add_half_illithid_appearance()

-- remove or restore the Volo ersatz eye appearance on the host character
Mods.ConsoleToolkit.character.remove_volo_ersatz_eye_appearance()
Mods.ConsoleToolkit.character.add_volo_ersatz_eye_appearance()

-- remove or restore Wyll's devil appearance; defaults to Wyll
Mods.ConsoleToolkit.character.remove_wyll_devil_appearance()
Mods.ConsoleToolkit.character.add_wyll_devil_appearance()

-- target explicit character IDs instead of the defaults
Mods.ConsoleToolkit.character.remove_half_illithid_appearance("<character_uuid>")
Mods.ConsoleToolkit.character.add_volo_ersatz_eye_appearance("<character_uuid>")
Mods.ConsoleToolkit.character.remove_wyll_devil_appearance("S_Player_Wyll_c774d764-4a17-48dc-b470-32ace9ce447d")
```

The appearance helpers only add/remove visual material overrides or transforms. They do not set story flags, tags, statuses, tadpole powers, or Volo/Wyll quest state.
`add_part_illithid_appearance` / `remove_part_illithid_appearance` and the older `partial_ceremorph` names are kept as aliases.

## Teleport Module

`ConsoleToolkit.teleport` provides convenience wrappers for moving companions to the host character.

```lua
server

-- teleport one character to the host character
Mods.ConsoleToolkit.teleport.to_host("3ed74f06-3c60-42dc-83f6-f034cb47c679")

-- teleport all companion constants to the host character
Mods.ConsoleToolkit.teleport.companions_to_host()
```

## Paladin Module

`ConsoleToolkit.paladin` provides thin wrappers around paladin oath APIs.

```lua
server

-- break the host character's paladin oath
Mods.ConsoleToolkit.paladin.break_oath()

-- restore the host character's paladin oath
Mods.ConsoleToolkit.paladin.redeem_oath()
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
- `print_missing_grants*` only prints what would be granted and never changes game state.
- `complete_goal_ignore_blocked` is the single-goal wrapper for `Osi.PROC_GLO_Backgrounds_CompleteGoal`. It deletes that goal's blocked DB row first if needed.
- `grant_missing_ignore_blocked*` checks background match and skips completed goals. If a goal is in `DB_GLO_Backgrounds_Blocked`, it deletes that blocked DB row before calling `Osi.PROC_GLO_Backgrounds_CompleteGoal`.
- The checked-in source has been renamed to `ConsoleToolkit`; build a fresh `.pak` before installing if you need a packed release.

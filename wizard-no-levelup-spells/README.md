# Wizard No Level Up Spells

BG3 mod project containing `WizardNoLevelUpSpells`, a progression-data mod for Wizards.

The intent is simple: Wizards should not learn free cantrips or spells from the level-up screen. Their spellbook should instead be filled through the game's normal scroll-learning flow.

## What It Changes

- Removes Wizard level-up spell and cantrip selection rewards.
- Targets the Wizard class progression and Wizard school progression data.
- Keeps the normal Wizard progression backbone: spell slots, Arcane Recovery, subclass progression, feats/ASI choices, and school features.

## What It Does Not Do

- Does not use Script Extender `AddSpell` calls.
- Does not directly edit a character's spellbook.
- Does not change scroll-learning UI, scroll-learning cost, or which scrolls the game considers learnable.
- Does not add scrolls or items to the player.

## Notes

- Characters that already learned spells or cantrips before installing this mod may keep those existing entries.
- For the cleanest result, install the mod before creating or respeccing the Wizard, then level through the normal level-up screen.
- The mod is meant to pair with normal Wizard scroll learning, not replace it.

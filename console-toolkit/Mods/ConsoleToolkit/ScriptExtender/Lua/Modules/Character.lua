-- Character utility console helpers.

ConsoleToolkit = ConsoleToolkit or {}
ConsoleToolkit.modules = ConsoleToolkit.modules or {}
ConsoleToolkit.character = ConsoleToolkit.character or {}
ConsoleToolkit.modules.character = ConsoleToolkit.character

-- Short alias for Script Extender console calls through Mods.ConsoleToolkit.*.
character = ConsoleToolkit.character

local function out(msg)
  ConsoleToolkit.out(msg)
end

local APPEARANCE = {
  HALF_ILLITHID = "398ca8ae-c3c0-47f5-8e45-d9402e198389",
  VOLO_ERSATZ_EYE = "dc46662a-d909-4df5-ad12-50a524150aff",
  WYLL = "S_Player_Wyll_c774d764-4a17-48dc-b470-32ace9ce447d",
  WYLL_DEVIL_TEMPLATE = "ORIGIN_Wyll_Devil_7ea87604-e604-4a6d-a7ac-b7b2f293c000",
  WYLL_DEVIL_RULE = "WyllDevil_884b16b1-e4e1-474a-8de4-fb1836491f01",
}

local function add_material_override(character_id, material_id, label)
  local target = ConsoleToolkit.utils.character_or_host(character_id)

  Osi.AddCustomMaterialOverride(target, material_id)
  out(string.format("Done | added %s appearance override | target=%s", label, tostring(target)))
end

local function remove_material_override(character_id, material_id, label)
  local target = ConsoleToolkit.utils.character_or_host(character_id)

  Osi.RemoveCustomMaterialOverride(target, material_id)
  out(string.format("Done | removed %s appearance override | target=%s", label, tostring(target)))
end

local function change_one_approval(companion_id, target, amount)
  Osi.ChangeApprovalRating(companion_id, target, 0, amount)
  out(string.format("[OK] changed approval=%d | companion=%s | target=%s", amount, tostring(companion_id), tostring(target)))
end

local function get_approval_or_zero(companion_id, target)
  local ok, approval = pcall(function()
    return Osi.GetApprovalRating(companion_id, target)
  end)

  if ok and approval ~= nil then
    return approval
  end

  return 0
end

function ConsoleToolkit.character.help()
  out("=== ConsoleToolkit.character Commands ===")
  out("Mods.ConsoleToolkit.character.change_approval(<amount>, <companion_uuid>)")
  out('Mods.ConsoleToolkit.character.change_approval("max", <companion_uuid>)')
  out("Mods.ConsoleToolkit.character.max_approval(<companion_uuid>)")
  out("Mods.ConsoleToolkit.character.start_change_appearance(<character_uuid>)")
  out("Mods.ConsoleToolkit.character.start_respec(<character_uuid>)")
  out("Mods.ConsoleToolkit.character.add_half_illithid_appearance(<character_uuid>)")
  out("Mods.ConsoleToolkit.character.remove_half_illithid_appearance(<character_uuid>)")
  out("Mods.ConsoleToolkit.character.add_volo_ersatz_eye_appearance(<character_uuid>)")
  out("Mods.ConsoleToolkit.character.remove_volo_ersatz_eye_appearance(<character_uuid>)")
  out("Mods.ConsoleToolkit.character.add_wyll_devil_appearance(<character_uuid>)")
  out("Mods.ConsoleToolkit.character.remove_wyll_devil_appearance(<character_uuid>)")
  out("Tip: change_approval amount defaults to 10; omit companion_uuid to apply to all constants.companions.")
  out("Tip: max_approval targets every DB_Players avatar, so co-op Tavs and Dark Urge avatars are included.")
  out("Tip: appearance/respec/material character_uuid defaults to GetHostCharacter(); Wyll devil character_uuid defaults to Wyll.")
end

function ConsoleToolkit.character.max_approval(companion_id)
  local players = ConsoleToolkit.utils.player_ids()
  local touched = 0

  for _, target in ipairs(players) do
    if companion_id ~= nil then
      local delta = 100 - get_approval_or_zero(companion_id, target)
      if delta ~= 0 then
        change_one_approval(companion_id, target, delta)
      end
      touched = touched + 1
    else
      for _, name in ipairs(ConsoleToolkit.constants.companion_names) do
        local id = ConsoleToolkit.constants.companions[name]
        if id ~= nil then
          local delta = 100 - get_approval_or_zero(id, target)
          if delta ~= 0 then
            change_one_approval(id, target, delta)
          end
          touched = touched + 1
        end
      end
    end
  end

  out(string.format(
    "Done | maxed approval | players=%d | companion_scope=%s | touched=%d",
    #players,
    companion_id ~= nil and tostring(companion_id) or "all constants.companions",
    touched
  ))
end

function ConsoleToolkit.character.change_approval(amount, companion_id)
  if amount == "max" then
    ConsoleToolkit.character.max_approval(companion_id)
    return
  end

  local target = GetHostCharacter()
  local value = ConsoleToolkit.utils.integer_or_default(amount, 10)

  if companion_id ~= nil then
    change_one_approval(companion_id, target, value)
    out(string.format("Done | changed approval for one companion | amount=%d | target=%s", value, tostring(target)))
    return
  end

  local changed = 0
  for _, name in ipairs(ConsoleToolkit.constants.companion_names) do
    local id = ConsoleToolkit.constants.companions[name]
    if id ~= nil then
      change_one_approval(id, target, value)
      changed = changed + 1
    end
  end

  out(string.format("Done | changed approval for all companions | amount=%d | target=%s | touched=%d", value, tostring(target), changed))
end

function ConsoleToolkit.character.start_change_appearance(character_id)
  local target = ConsoleToolkit.utils.character_or_host(character_id)

  Osi.StartChangeAppearance(target)
  out(string.format("Done | started change appearance | target=%s", tostring(target)))
end

function ConsoleToolkit.character.start_respec(character_id)
  local target = ConsoleToolkit.utils.character_or_host(character_id)

  Osi.StartRespec(target)
  out(string.format("Done | started respec | target=%s", tostring(target)))
end

function ConsoleToolkit.character.add_half_illithid_appearance(character_id)
  add_material_override(character_id, APPEARANCE.HALF_ILLITHID, "half-illithid")
end

function ConsoleToolkit.character.remove_half_illithid_appearance(character_id)
  remove_material_override(character_id, APPEARANCE.HALF_ILLITHID, "half-illithid")
end

ConsoleToolkit.character.add_part_illithid_appearance = ConsoleToolkit.character.add_half_illithid_appearance
ConsoleToolkit.character.remove_part_illithid_appearance = ConsoleToolkit.character.remove_half_illithid_appearance
ConsoleToolkit.character.add_partial_ceremorph_appearance = ConsoleToolkit.character.add_half_illithid_appearance
ConsoleToolkit.character.remove_partial_ceremorph_appearance = ConsoleToolkit.character.remove_half_illithid_appearance

function ConsoleToolkit.character.add_volo_ersatz_eye_appearance(character_id)
  add_material_override(character_id, APPEARANCE.VOLO_ERSATZ_EYE, "Volo ersatz eye")
end

function ConsoleToolkit.character.remove_volo_ersatz_eye_appearance(character_id)
  remove_material_override(character_id, APPEARANCE.VOLO_ERSATZ_EYE, "Volo ersatz eye")
end

function ConsoleToolkit.character.add_wyll_devil_appearance(character_id)
  local target = character_id or APPEARANCE.WYLL

  Osi.Transform(target, APPEARANCE.WYLL_DEVIL_TEMPLATE, APPEARANCE.WYLL_DEVIL_RULE)
  out(string.format("Done | added Wyll devil appearance transform | target=%s", tostring(target)))
end

function ConsoleToolkit.character.remove_wyll_devil_appearance(character_id)
  local target = character_id or APPEARANCE.WYLL

  Osi.RemoveTransforms(target)
  out(string.format("Done | removed Wyll devil appearance transform | target=%s", tostring(target)))
end

out("Mods.ConsoleToolkit.character loaded. Run Mods.ConsoleToolkit.character.help()")

-- Item and equipment console helpers.

ConsoleToolkit = ConsoleToolkit or {}
ConsoleToolkit.modules = ConsoleToolkit.modules or {}
ConsoleToolkit.items = ConsoleToolkit.items or {}
ConsoleToolkit.modules.items = ConsoleToolkit.items

-- Short alias for Script Extender console calls through Mods.ConsoleToolkit.*.
items = ConsoleToolkit.items

local PROLOGUE_CAMP_CLOTHING = {
    { stat = "ARM_Camp_Body_Astarion", template = "b7392453-6569-4c24-9a1b-cbaea7cebac8" },
    { stat = "ARM_Underwear_Astarion", template = "4b30a649-fd88-4f64-a57b-1149d7b9ac41" },
    { stat = "ARM_Camp_Shoes_Astarion", template = "4700fad1-769e-4831-9b3f-4ead08c49cfa" },
    { stat = "ARM_Camp_Body_Gale", template = "c56bbf29-2315-415e-a488-fada851828ea" },
    { stat = "ARM_Underwear_Gale", template = "5cdc0fe0-dbda-4f31-89f8-9e16782daef1" },
    { stat = "ARM_Camp_Shoes_Gale", template = "cb28ea7d-2838-43e7-a807-11277c44facb" },
    { stat = "ARM_Camp_Body_Halsin", template = "dc74db6c-14b2-44fa-8415-0dd1194e90e2" },
    { stat = "ARM_Underwear_Halsin", template = "9ebb9117-a0ae-46f2-a243-8d67650e9586" },
    { stat = "ARM_Camp_Shoes_Halsin", template = "42de5102-7a39-44d2-b1d8-645ec4d8b0ce" },
    { stat = "ARM_Camp_Body_Jaheira", template = "0d0d9c0f-e9aa-4ba4-a0a9-1a0b7b7069ca" },
    { stat = "ARM_Underwear_Jaheira", template = "91259e65-dd71-4312-ba3c-c55757978788" },
    { stat = "ARM_Camp_Shoes_Jaheira", template = "556de2bd-99a6-4d62-b78c-d4681ce5bdfa" },
    { stat = "ARM_Camp_Body_Laezel", template = "54de4a07-c57c-421e-912c-7e8bd93ca0c4" },
    { stat = "ARM_Underwear_Laezel", template = "185ab1be-e93d-4518-b053-d6d4d7168d68" },
    { stat = "ARM_Camp_Shoes_Laezel", template = "212bf756-b237-4ede-9c67-e871fd60e788" },
    { stat = "ARM_Camp_Shoes_Wyll", template = "b307af36-a2da-4c01-aac3-a31771edd407" },
    { stat = "ARM_Camp_Body_Minsc", template = "42ff9d36-849d-4777-968c-8cf9ca7d8027" },
    { stat = "ARM_Underwear_Minsc", template = "48a3ffbe-f14e-4cfe-b45e-ebadb3af0fd4" },
    { stat = "ARM_Camp_Shoes_Minsc", template = "836e13ab-78a6-4ca3-ba8e-adc4c25205f1" },
    { stat = "ARM_Camp_Body_Minthara", template = "29a31736-6f9d-46ef-880d-ac3157187202" },
    { stat = "ARM_Underwear_Minthara", template = "73874ef8-a3c4-4a68-8d2a-ed3d580dfb52" },
    { stat = "ARM_Camp_Shoes_Minthara", template = "f107cc6a-3a6e-4a58-be16-fbe73b3f7ae8" },
    { stat = "ARM_Camp_Body_Karlach", template = "5c79e518-2c59-41c5-84a7-d43a58e76d09" },
    { stat = "ARM_Underwear_Karlach", template = "e865db4c-4df3-48e9-8cf3-5abad75510ba" },
    { stat = "ARM_Camp_Shoes_Karlach", template = "b8f42945-a42e-46cb-a424-3a0a5e97157a" },
    { stat = "ARM_Camp_Body_Shadowheart", template = "7062410b-439c-4f2f-bc48-1c16ab1ace20" },
    { stat = "ARM_Underwear_Shadowheart", template = "b460bd0c-58fe-4a56-831c-af92fd4ba7e2" },
    { stat = "ARM_Camp_Shoes_Shadowheart", template = "e92e4dad-8e96-4f27-aacb-cc430df0bc75" },
    { stat = "ARM_Camp_Body_Wyll", template = "bd2ac836-5584-41e5-b4ff-01782c0dec6d" },
    { stat = "ARM_Underwear_Wyll", template = "1930ceec-4a50-43d9-8589-94593c449be4" },
}

local EPILOGUE_CAMP_CLOTHING = {
    { stat = "EPI_Camp_Spawn", template = "13084436-5d19-4cef-ae53-02857497fc28" },
    { stat = "EPI_Camp_Shoes_Spawn", template = "5fdac3e9-455c-49e0-83a0-3222108f5651" },
    { stat = "EPI_Camp_Ascendant", template = "76f26388-daff-440a-a4f3-dba4f78e548c" },
    { stat = "EPI_Camp_Shoes_Ascendant", template = "8b6555b8-fcf1-4535-b9cd-7e94208ce840" },
    { stat = "EPI_Camp_Gale", template = "1cb24313-5ed1-43b7-ab4a-cdf2118422ea" },
    { stat = "EPI_Camp_Shoes_Gale", template = "dbe8fe69-736f-4ceb-8a98-57d1f9a639be" },
    { stat = "EPI_Camp_Gale_God", template = "1068659c-f12b-4930-ac4f-c4892af58cd7" },
    { stat = "EPI_Camp_Gale_God_Player", template = "73dd34d5-873c-445c-be94-705d611f63b2" },
    { stat = "EPI_Camp_Halsin", template = "d873fb44-94c7-4b74-a272-1d2e5e43a7ef" },
    { stat = "EPI_Camp_Shoes_Halsin", template = "8a40655e-69df-45ab-b1cd-7164c2e29fd4" },
    { stat = "EPI_Camp_Jaheira_Harper", template = "bdef460b-374e-45d6-86f7-d272a927b380" },
    { stat = "EPI_Camp_Shoes_Jaheira_Harper", template = "f7018235-a244-43f0-86e9-25b38fcd11a6" },
    { stat = "EPI_Camp_Jaheira", template = "e22c8a04-ab6b-4315-a784-81fabb2b8db9" },
    { stat = "EPI_Camp_Shoes_Jaheira", template = "6d7169af-9b41-42dc-be4f-ece1486cd70e" },
    { stat = "EPI_Camp_Avernus", template = "24149d5d-c509-48dc-b026-491c11e60a5c" },
    { stat = "EPI_Camp_Shoes_Avernus", template = "c36967e4-26c5-4f2f-b25b-f351a6bac804" },
    { stat = "EPI_Camp_Laezel_Faerun", template = "9747dbb0-0f92-483e-80fc-391390d416f9" },
    { stat = "EPI_Camp_Shoes_Laezel_Faerun", template = "cba5d95b-d2a6-4253-abe1-c81da0391c0c" },
    { stat = "EPI_Camp_Laezel_Gith", template = "8c953ad4-1103-4215-9a09-ff95e51cc8e4" },
    { stat = "EPI_Camp_Shoes_Laezel_Gith", template = "a8f1228b-1cdc-4b5c-abf4-d19f41b6bc30" },
    { stat = "EPI_Camp_Minsc", template = "54c4b72d-0f2d-40be-bab7-c70c5f3adb97" },
    { stat = "EPI_Camp_Shoes_Minsc", template = "19963131-982a-44b2-afd8-c2edee9e1b3a" },
    { stat = "EPI_Camp_Prison", template = "ffe2cacb-8073-4e6d-bf81-057da0c5030c" },
    { stat = "EPI_Camp_Minthara_Drow", template = "9c035563-05ee-47e1-a3e0-e0420a07f534" },
    { stat = "EPI_Camp_Shoes_Minthara_Drow", template = "7e633d92-271b-4aaf-9880-dd1643bd41a3" },
    { stat = "EPI_Camp_Minthara", template = "7d65044d-0d01-44c8-b665-165f0ecc768c" },
    { stat = "EPI_Camp_Shoes_Minthara", template = "00d8d8fc-1820-47de-9956-5d4a68a40700" },
    { stat = "EPI_Camp_Selune", template = "79bb5a64-2019-4818-a898-de179b6bc44c" },
    { stat = "EPI_Camp_Shoes_Selune", template = "4f7febc5-fadd-45f2-96c1-d2447fec12bd" },
    { stat = "EPI_Camp_Shar", template = "8fc09773-7083-466a-8988-e030b6d647e3" },
    { stat = "EPI_Camp_Shoes_Shar", template = "e3b092c6-82e8-49df-843c-40d643410171" },
    { stat = "EPI_Camp_Wyll_Duke", template = "7f89e3b8-61ef-498b-bd1b-77f996c5ec42" },
    { stat = "EPI_Camp_Shoes_Wyll_Duke", template = "4aa0dbb1-f51a-45bc-8a58-814ac5063035" },
    { stat = "EPI_Camp_Wyll_Blade", template = "46c97e62-7d3e-449f-a130-586e8e871947" },
    { stat = "EPI_Camp_Shoes_Wyll_Blade", template = "c3f02e6c-d519-40d1-b686-a241a9f9972e" },
    { stat = "EPI_Camp_DU_Rags", template = "bdc2247f-32a3-4ded-bffc-8aeb770f23d4" },
    { stat = "EPI_Camp_PartyTav_1", template = "edb02b0e-3d91-4a81-a37d-f151bad68c6d" },
    { stat = "EPI_Camp_Shoes_PartyTav_1", template = "7dec9f3e-3a90-4588-a995-2986340866c6" },
    { stat = "EPI_Camp_PartyTav_2", template = "98cdd18d-2d8a-4aca-a46b-c4829833482f" },
    { stat = "EPI_Camp_Shoes_PartyTav_2", template = "ff7d64c3-3969-44f6-98ee-0add1fb69fef" },
    { stat = "EPI_Camp_PartyTav_3", template = "782e430e-caef-42eb-abc4-6406544e9714" },
    { stat = "EPI_Camp_Shoes_PartyTav_3", template = "773924ee-02cd-42e7-8480-0c42896f700e" },
    { stat = "EPI_Camp_PartyTav_4", template = "eedda7b5-c1f4-4633-8034-30e63f7ce581" },
    { stat = "EPI_Camp_Shoes_PartyTav_4", template = "810351d6-75ff-4c95-8f65-fcbfb5d0c19d" },
    { stat = "BASE_Vanity_Body_Epilogues", template = "543d5c85-d5c5-4768-be78-b8173c4e6450" },
    { stat = "BASE_Vanity_Shoes_Epilogues", template = "dc59e71e-a303-497d-9ab7-7354cf8897d8" },
}

local DIGITAL_DELUXE_CLOTHING = {
    { stat = "DLC_TWITCH_Camp_Body", template = "9dc4dafd-590a-44ec-8523-95136f46be9e" },
    { stat = "DLC_TWITCH_Camp_Shoes", template = "14339654-a714-4341-b03f-62530508c8e3" },
    { stat = "DLC_TWITCH_Underwear_A", template = "bf974183-9bf5-4086-9742-a2deef9e7675" },
    { stat = "DLC_TWITCH_Underwear_B", template = "f6af55dd-a75a-46ea-87f0-89ebf4e7b74e" },
}

local function out(msg)
  ConsoleToolkit.out(msg)
end

local function resolve_target(character_id)
  return character_id or GetHostCharacter()
end

local function grant_templates(label, templates, character_id, dry_run, show_notification)
  local target = resolve_target(character_id)
  if dry_run == nil then
    dry_run = false
  end
  if show_notification == nil then
    show_notification = 1
  end

  local granted = 0
  for _, item in ipairs(templates) do
    if dry_run then
      out(string.format("[DRY][%s] would add %s (%s) to %s", label, item.stat, item.template, tostring(target)))
    else
      Osi.TemplateAddTo(item.template, target, 1, show_notification)
      out(string.format("[OK][%s] added %s to %s", label, item.stat, tostring(target)))
    end
    granted = granted + 1
  end

  out(string.format(
    "Done | set=%s | target=%s | dry_run=%s | touched=%d",
    label,
    tostring(target),
    tostring(dry_run),
    granted
  ))
end

function ConsoleToolkit.items.help()
  out("=== ConsoleToolkit.items Commands ===")
  out("ConsoleToolkit.items.grant_prologue_camp_clothing(<character_uuid>, <dry_run>, <show_notification>)")
  out("ConsoleToolkit.items.grant_epilogue_camp_clothing(<character_uuid>, <dry_run>, <show_notification>)")
  out("ConsoleToolkit.items.grant_digital_deluxe_clothing(<character_uuid>, <dry_run>, <show_notification>)")
  out("ConsoleToolkit.items.grant_twitch_clothing(<character_uuid>, <dry_run>, <show_notification>)")
  out("Tip: character_uuid defaults to GetHostCharacter(); dry_run defaults to false; show_notification defaults to 1.")
end

function ConsoleToolkit.items.grant_prologue_camp_clothing(character_id, dry_run, show_notification)
  grant_templates("Prologue Camp Clothing", PROLOGUE_CAMP_CLOTHING, character_id, dry_run, show_notification)
end

function ConsoleToolkit.items.grant_epilogue_camp_clothing(character_id, dry_run, show_notification)
  grant_templates("Epilogue Camp Clothing", EPILOGUE_CAMP_CLOTHING, character_id, dry_run, show_notification)
end

function ConsoleToolkit.items.grant_digital_deluxe_clothing(character_id, dry_run, show_notification)
  grant_templates("Digital Deluxe Clothing", DIGITAL_DELUXE_CLOTHING, character_id, dry_run, show_notification)
end

function ConsoleToolkit.items.grant_twitch_clothing(character_id, dry_run, show_notification)
  ConsoleToolkit.items.grant_digital_deluxe_clothing(character_id, dry_run, show_notification)
end

out("ConsoleToolkit.items loaded. Run ConsoleToolkit.items.help()")

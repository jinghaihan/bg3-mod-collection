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

local SCROLLS = {
    { stat = "OBJ_Scroll_ChillTouch", template = "79faf049-d503-46eb-a018-69e1975777d7" },
    { stat = "OBJ_Scroll_FireBolt", template = "fdfe5d75-0e8b-47f8-b128-d57081cb8981" },
    { stat = "OBJ_Scroll_RayOfFrost", template = "f6cbfbb3-7eab-4f78-afde-073756c4e26d" },
    { stat = "OBJ_Scroll_ShockingGrasp", template = "a9ced623-a25d-4d2b-bca5-644b7230c869" },
    { stat = "OBJ_Scroll_AnimalFriendship", template = "3d992632-dc98-43b1-85e5-b59ba5a6aa9a" },
    { stat = "OBJ_Scroll_BurningHands", template = "bc00df72-3c98-4bf2-9650-28e08f79b57c" },
    { stat = "OBJ_Scroll_CharmPerson", template = "2315f935-a188-4665-9ae0-986c7a9b0021" },
    { stat = "OBJ_Scroll_ChromaticOrb", template = "d338fcb9-aaf5-48b1-8333-2dd4d9f70e1b" },
    { stat = "OBJ_Scroll_ColorSpray", template = "c7c92bc3-e856-4403-b509-9b0491f455cd" },
    { stat = "OBJ_Scroll_DisguiseSelf", template = "b3376ca4-393c-4191-aa67-a02c94d6a236" },
    { stat = "OBJ_Scroll_ExpeditiousRetreat", template = "eedf0539-6a47-480e-8b23-a133b222241f" },
    { stat = "OBJ_Scroll_FalseLife", template = "7d76665a-3b9e-4495-a3c6-a05340704194" },
    { stat = "OBJ_Scroll_FeatherFall", template = "82cbfcd2-cf80-4acd-9f1f-51835693b0e6" },
    { stat = "OBJ_Scroll_FogCloud", template = "dcb51bec-90bd-4d0a-942d-72034782bdf5" },
    { stat = "OBJ_Scroll_Goodberry", template = "dff353d0-c1d4-43af-8664-bf08a9ffae07" },
    { stat = "OBJ_Scroll_Grease", template = "094c9b7f-0b7d-4813-92ea-7267afb62b07" },
    { stat = "OBJ_Scroll_IceKnife", template = "f26320fa-9a25-4f79-80fc-e356268cf474" },
    { stat = "OBJ_Scroll_MageArmor", template = "2ccab07d-0ccb-45e6-8f43-8ffb6a62da11" },
    { stat = "OBJ_Scroll_MagicMissile", template = "945cd4f0-991b-4663-b72e-790d49fee27e" },
    { stat = "OBJ_Scroll_ProtectionFromEvilAndGood", template = "03771ebc-83ca-45d2-8bd5-d382b6d6d824" },
    { stat = "OBJ_Scroll_RayOfSickness", template = "22ef638a-206f-4874-8f68-e2a378df1158" },
    { stat = "OBJ_Scroll_Sleep", template = "2ce88bf0-fe06-46bd-b71e-18bc6dc8eb9d" },
    { stat = "OBJ_Scroll_SummonQuasit", template = "f912ea9b-0e2f-45b4-b12d-fa6ec89dc758" },
    { stat = "OBJ_Scroll_HideousLaughter", template = "8bc1a0d8-af28-45b2-b1ca-1f15e3c47b1b" },
    { stat = "OBJ_Scroll_Thunderwave", template = "94caa680-50b8-46b1-b775-19150d783b2f" },
    { stat = "OBJ_Scroll_WitchBolt", template = "e69f52a4-3d86-4f08-a9b4-c70ba4cc3070" },
    { stat = "OBJ_Scroll_Aid", template = "3e85f140-2284-430b-b11f-2126cd85b567" },
    { stat = "OBJ_Scroll_ArcaneLock", template = "05da1a09-2d22-4299-b4a0-c4538a91f91c" },
    { stat = "OBJ_Scroll_Blindness", template = "2c6caac0-1684-4324-abba-0b849a9add74" },
    { stat = "OBJ_Scroll_Blur", template = "a8b34fd5-d643-49ad-98d3-d5841492b338" },
    { stat = "OBJ_Scroll_CloudOfDaggers", template = "33421d4f-1cac-4196-a85e-0b07bcb3ecf2" },
    { stat = "OBJ_Scroll_CrownOfMadness", template = "701a7df0-728e-494a-ab2f-146aed4e8c7f" },
    { stat = "OBJ_Scroll_Darkness", template = "caa812b9-9362-4c38-aef0-e3f6eb288dba" },
    { stat = "OBJ_Scroll_Darkvision", template = "0d737a55-c337-4e8f-b31f-a17273099013" },
    { stat = "OBJ_Scroll_DetectThoughts", template = "126cc673-1151-4113-b1bf-98457233441b" },
    { stat = "OBJ_Scroll_Enlarge", template = "7c4c3ae1-26ac-4765-a5d5-586976e0e458" },
    { stat = "OBJ_Scroll_FlameBlade", template = "a6d216e9-c9e9-4310-b155-0e4f50682377" },
    { stat = "OBJ_Scroll_FlamingSphere", template = "0922de82-149f-4cac-aa98-e26222fd7714" },
    { stat = "OBJ_Scroll_GustOfWind", template = "6bedf433-994f-4624-bb2a-cdf6f46d539a" },
    { stat = "OBJ_Scroll_HoldPerson", template = "5e077657-8b5e-4e69-ae2e-95eab691fa41" },
    { stat = "OBJ_Scroll_Invisibility", template = "6ed22182-90a6-418a-8aa7-909b9e77aa47" },
    { stat = "OBJ_Scroll_Knock", template = "4c1a886a-7db5-4e00-bbc6-d4243534f057" },
    { stat = "OBJ_Scroll_MagicWeapon", template = "ccf1bd99-e807-44e6-9a0a-7645ad533a8f" },
    { stat = "OBJ_Scroll_AcidArrow", template = "0fa4bdab-9ef1-4575-b063-b3e9d359d593" },
    { stat = "OBJ_Scroll_MirrorImage", template = "019d8804-56ee-44eb-959a-db5377cda8ae" },
    { stat = "OBJ_Scroll_MistyStep", template = "9a2a3fcc-d948-4463-b88b-a9d61b77b015" },
    { stat = "OBJ_Scroll_RayOfEnfeeblement", template = "cd1da9c5-c9ea-4d2a-93ce-e201c97eded9" },
    { stat = "OBJ_Scroll_ScorchingRay", template = "577a83c9-0bb7-4670-b0e9-d9a4738f6a0a" },
    { stat = "OBJ_Scroll_SeeInvisibility", template = "2e7fc397-cb84-4573-b6c7-1c7a8f2742d6" },
    { stat = "OBJ_Scroll_Shatter", template = "2ad118cb-b11f-45ca-a206-7575bbbaccc6" },
    { stat = "OBJ_Scroll_Web", template = "2eedb4ac-47fa-4039-9684-8b4bb0923a26" },
    { stat = "OBJ_Scroll_AnimateDead", template = "8b9b4657-93f3-4382-b6e0-a587902abcba" },
    { stat = "OBJ_Scroll_BestowCurse", template = "48fbab09-ede1-4093-9223-38c9e172c061" },
    { stat = "OBJ_Scroll_Blink", template = "d3800e05-635f-47b3-80b1-1a7c4161cf89" },
    { stat = "OBJ_Scroll_Fear", template = "4cdb2434-0ffa-4fb1-9c42-d6451978f35b" },
    { stat = "OBJ_Scroll_FeignDeath", template = "6e13fbf8-3db5-4420-8691-653d5ecb753e" },
    { stat = "OBJ_Scroll_Fireball", template = "79d2bb95-53fc-4e41-a004-5e1b83db8de7" },
    { stat = "OBJ_Scroll_Fly", template = "1df15994-c860-4930-beed-3135b74025fa" },
    { stat = "OBJ_Scroll_GaseousForm", template = "4c026e53-4000-4818-913c-a5662ee7c061" },
    { stat = "OBJ_Scroll_GlyphOfWarding", template = "056f10e1-01e7-4622-907f-faad8d48bbe6" },
    { stat = "OBJ_Scroll_Haste", template = "96d4aba5-bd76-4bae-a726-37a6c96776ab" },
    { stat = "OBJ_Scroll_HypnoticPattern", template = "bdf15fb0-d9df-4509-ad70-42b5fad11971" },
    { stat = "OBJ_Scroll_LightningBolt", template = "83600284-8f78-409f-a0e0-d262b2bdea64" },
    { stat = "OBJ_Scroll_ProtectionFromEnergy", template = "9f8502bf-727f-40c7-93a3-5fab6ba2e2f5" },
    { stat = "OBJ_Scroll_RemoveCurse", template = "dea31400-25e5-4e69-bb76-14430fe46673" },
    { stat = "OBJ_Scroll_SleetStorm", template = "be05f7d0-ffa0-46e3-a0d6-66e3333159f1" },
    { stat = "OBJ_Scroll_Slow", template = "4c990ca3-01f6-4536-b8f3-c26cd9a0ca8b" },
    { stat = "OBJ_Scroll_SpeakWithDead", template = "36d01b98-1702-4d00-81a9-1b8469dd67a5" },
    { stat = "OBJ_Scroll_StinkingCloud", template = "0f0a7a12-1c77-423a-b16e-4a9a5480c05e" },
    { stat = "OBJ_Scroll_VampiricTouch", template = "6fd2d3d4-801c-4591-9c05-db8a68e51808" },
    { stat = "OBJ_Scroll_Banishment", template = "82719943-71e0-4eb2-bc4f-c8c0dd02c47c" },
    { stat = "OBJ_Scroll_Blight", template = "e0ee9263-3740-44fe-80da-4315cb836aef" },
    { stat = "OBJ_Scroll_Confusion", template = "7634cc33-d16b-4640-ba7c-8c6a26653591" },
    { stat = "OBJ_Scroll_ConjureMinorElemental", template = "a30864e5-06f0-4d14-9ea4-cb6870c0ddfe" },
    { stat = "OBJ_Scroll_DimensionDoor", template = "75452ba5-5758-417c-b661-8832eb64df66" },
    { stat = "OBJ_Scroll_BlackTentacles", template = "e9fae419-8c7a-4d5d-950f-94675a2aff07" },
    { stat = "OBJ_Scroll_FireShield_Warm", template = "6b87f7b4-441c-41cf-92c3-29e258747454" },
    { stat = "OBJ_Scroll_FireShield_Chill", template = "5d2e1c40-e85e-4027-aefe-b9731a2de2c9" },
    { stat = "OBJ_Scroll_Invisibility_Greater", template = "795e4282-27c3-4177-b532-9e6559a26531" },
    { stat = "OBJ_Scroll_IceStorm", template = "e8c3ad4e-37f0-46c8-bf25-0ddc2dcb0139" },
    { stat = "OBJ_Scroll_PhantasmalKiller", template = "3b802734-ad6e-45a4-988b-f7241636e5e9" },
    { stat = "OBJ_Scroll_Polymorph", template = "389da9ab-bee7-447c-9bed-f1021ddc94d4" },
    { stat = "OBJ_Scroll_Stoneskin", template = "7f39977f-bcab-4dda-933f-bd70cb333ecc" },
    { stat = "OBJ_Scroll_WallOfFire", template = "0f3c7369-d0bd-4b97-960d-1407f4c8eebf" },
    { stat = "UNI_LOW_CurriculumOfStrategyScroll", template = "21e67b0e-913d-411a-9046-6c54e8d0bf53" },
    { stat = "OBJ_Scroll_Cloudkill", template = "0e793d2d-1cd7-4b90-a71b-821423e50969" },
    { stat = "OBJ_Scroll_ConeOfCold", template = "e81e7b31-8e7a-4fc1-977d-9a9a58fdd4a0" },
    { stat = "OBJ_Scroll_ConjureElemental", template = "c0e92dfa-29cf-46e8-8b35-8bded679df64" },
    { stat = "UNI_LOW_DethroneScroll", template = "b2e1168a-021d-4a81-a041-6d2e1421a1fb" },
    { stat = "OBJ_Scroll_DominatePerson", template = "3b447e07-3e73-4906-9f7e-63a87e2da909" },
    { stat = "OBJ_Scroll_HoldMonster", template = "d621c19f-d5c8-433c-bc75-7f2eb87d2f0a" },
    { stat = "OBJ_Scroll_PlanarBinding", template = "6ac3b9ab-fdb4-47e8-8a35-91747de2afc8" },
    { stat = "OBJ_Scroll_Seeming", template = "d2573c9b-6de2-45bd-8032-b8a59432f4b5" },
    { stat = "OBJ_Scroll_Telekinesis", template = "1d5ecaca-310b-4622-b302-81331c0a8e9e" },
    { stat = "OBJ_Scroll_WallOfStone", template = "d13587f4-a1f4-4833-bd1e-da1c7951d680" },
    { stat = "UNI_LOW_BestialCommunionScroll", template = "b627f83f-8533-4440-95a0-ad2f319fe4ed" },
    { stat = "OBJ_Scroll_ChainLightning", template = "13105f7d-55fa-4292-abfe-b9d80054b48e" },
    { stat = "OBJ_Scroll_CircleOfDeath", template = "ad31110a-aa9a-4427-925a-9952bfbef45a" },
    { stat = "OBJ_Scroll_Disintegrate", template = "3f737706-57ca-45e6-b0d1-45238da76329" },
    { stat = "OBJ_Scroll_Eyebite", template = "cecb1802-b2c0-4d65-aa08-aa15ca3619eb" },
    { stat = "OBJ_Scroll_FleshToStone", template = "a9135751-3a8a-4070-9f3a-11d24d123a3f" },
    { stat = "OBJ_Scroll_GlobeOfInvulnerability", template = "8d4c06d1-e504-49b0-a4fa-5179ab717f1e" },
    { stat = "OBJ_Scroll_FreezingSphere", template = "74d0e4f0-de97-4097-a7e7-f5759a375c81" },
    { stat = "OBJ_Scroll_IrresistibleDance", template = "3c8db4fb-c10b-415d-b9cd-c3254265b778" },
    { stat = "OBJ_Scroll_Sunbeam", template = "049d70c4-7ea3-4b6c-af6f-44dab7813a89" },
    { stat = "OBJ_Scroll_WallOfIce", template = "e7dc56bc-b169-4a46-b8ee-cc6474dd7b15" },
    { stat = "OBJ_Scroll_ArcaneEye", template = "5314d1eb-5771-47b5-80a7-2ee093ef4618" },
    { stat = "OBJ_Scroll_Counterspell", template = "17f828a4-5684-42dd-9f08-ff99ba43358a" },
    { stat = "OBJ_Scroll_DispelMagic", template = "bc5c0bcf-144f-46ed-bcde-e6bd1225efb9" },
    { stat = "OBJ_Scrolls_FindFamiliar", template = "fb975b01-40d5-49a3-b60a-d2f13a1f8009" },
    { stat = "OBJ_Scroll_Jump", template = "e1f15103-bb95-476f-8b09-091f51b2f645" },
    { stat = "OBJ_Scroll_Longstrider", template = "82370a33-5243-4fad-9880-b0a8c2b5a225" },
    { stat = "OBJ_Scroll_ResilientSphere", template = "f5bf39c0-2df3-4cd4-842c-c1862e6f80aa" },
    { stat = "OBJ_Scroll_PhantasmalForce", template = "2eb2147d-5bcb-4b0e-ac73-b2a4d1deeb77" },
}

local ARROWS = {
    { stat = "OBJ_ArrowOfAberrationSlaying", template = "1545f451-3fc5-4c1b-970e-572f9ace630c" },
    { stat = "OBJ_ArrowOfAcid", template = "0bfb72d2-0e8e-4d16-aeae-3159b0d4b195" },
    { stat = "OBJ_ArrowOfAntimagic", template = "c9871e4a-633e-4b81-9115-8ffd0f69ee6a" },
    { stat = "OBJ_ArrowOfBeastSlaying", template = "86e46f4a-6789-47ef-ab85-449ca36b1b20" },
    { stat = "OBJ_ArrowOfConstructSlaying", template = "86a4dd98-80b1-4778-b498-e3a49b1dec37" },
    { stat = "OBJ_ArrowOfDarkness", template = "844c19ce-9e8f-4119-8856-8fa2029461b1" },
    { stat = "OBJ_ArrowOfDragonSlaying", template = "437835b4-0d13-47b7-8aca-5da4f948783b" },
    { stat = "OBJ_ArrowOfElementalSlaying", template = "0d81014f-cc7f-4c79-9477-b8cda9738c72" },
    { stat = "OBJ_ArrowOfFiendSlaying", template = "04ba10a0-ca33-47e6-9810-0b7234700c4a" },
    { stat = "OBJ_ArrowOfFire", template = "9a142fae-bcea-4e88-a407-16d3b27468b9" },
    { stat = "OBJ_ArrowOfHumanoidSlaying", template = "3c2c6a61-e348-4222-9ba3-58a4d49d558c" },
    { stat = "OBJ_ArrowOfIce", template = "2e297d80-823b-4200-926e-6ca23f488090" },
    { stat = "OBJ_ArrowOfWraithsEmbrace", template = "a61c8248-1595-450f-bcc9-2ed1d9853739" },
    { stat = "OBJ_ArrowOfLightning", template = "1b0f095b-cb22-4bf9-aecf-4e5a26504ec8" },
    { stat = "OBJ_ArrowOfRicochet", template = "b11b3f7f-d8ec-41db-93b9-24474aea31e3" },
    { stat = "OBJ_ArrowOfMonstrositySlaying", template = "d7645507-6c0c-48ff-aa1b-57092d139f22" },
    { stat = "OBJ_ArrowOfDetonation", template = "a0985797-4ec7-475c-8e11-0361e387f39a" },
    { stat = "OBJ_ArrowOfDispelling", template = "ac23602b-ceee-4ef3-a6b8-601e40a5aa6f" },
    { stat = "OBJ_ArrowOfTeleportation", template = "4cf7bbbb-1d1b-4bec-b82a-cdc3cce33f7a" },
    { stat = "OBJ_ArrowOfUndeadSlaying", template = "ae58df6b-0fc9-48ff-9d36-52bf9bc22204" },
    { stat = "OBJ_ArrowOfSmokepowder", template = "0788a2bb-c732-4ebb-abf9-2ef150f509be" },
    { stat = "OBJ_ArrowOfCelestialSlaying", template = "f516862d-5a05-426a-a8a1-1486b35b68f8" },
    { stat = "OBJ_ArrowOfFeySlaying", template = "21a2ef96-97ac-4372-95d7-676174610abc" },
    { stat = "OBJ_ArrowOfGiantSlaying", template = "a86bf6b2-2e75-4464-ad65-2bafa89e73aa" },
    { stat = "OBJ_ArrowOfOozeSlaying", template = "5931f0c7-ddd7-4e3b-aeef-64b0e7eefb70" },
    { stat = "OBJ_ArrowOfPlantSlaying", template = "ab4ed528-cf26-417d-a751-981f7c83066f" },
}

local DYES = {
    { stat = "OBJ_Dye_Remover", template = "19c7bbb1-29f5-4ec9-a72c-74a73318f8da" },
    { stat = "OBJ_Dye_BlueYellow", template = "a4c2594e-33a6-49b2-ab6f-e992a3e0257e" },
    { stat = "OBJ_Dye_Green", template = "e6f417bd-9d84-416f-8c96-5a6917977b77" },
    { stat = "OBJ_Dye_Blue", template = "a94ac1cd-96c9-4775-8dcd-c2b581bfeb50" },
    { stat = "OBJ_Dye_RedBrown", template = "6904ea3d-89b6-4db7-a0bc-d890423e9312" },
    { stat = "OBJ_Dye_Ocean", template = "54cd5913-5226-4143-9186-6c1a8499de1c" },
    { stat = "OBJ_Dye_Orange", template = "1bb2ba7b-1ac3-4c2e-bcd3-85886d294204" },
    { stat = "OBJ_Dye_Teal", template = "6d90deb8-8df3-4a6f-b31f-f13cf2eb68f9" },
    { stat = "OBJ_Dye_OrangeBlue", template = "84f7b0a1-8840-47a1-a27a-1ac79e383520" },
    { stat = "OBJ_Dye_Purple_02", template = "fecebc29-385d-4bef-a18a-79705fb0ecf3" },
    { stat = "OBJ_Dye_Red", template = "809f228e-8d2b-46b8-8a33-51181505bc61" },
    { stat = "OBJ_Dye_BlueGreen", template = "b702ddc5-f4fc-4976-adc4-18a8ddaab8d5" },
    { stat = "OBJ_Dye_GreenSage", template = "ad60be55-7a95-4dcb-ae55-908a97f9955a" },
    { stat = "OBJ_Dye_Golden", template = "09e48b43-f567-4acc-b98d-0c86c1396084" },
    { stat = "OBJ_Dye_BlueYellow_02", template = "1dec170b-101f-457b-b22d-8d38c45168c7" },
    { stat = "OBJ_Dye_BlackBlue", template = "02bb51c0-00e5-408c-8e11-8de7b9580c04" },
    { stat = "OBJ_Dye_BlackRed", template = "bb108620-186f-4a00-b7de-af9329d5497b" },
    { stat = "OBJ_Dye_PurpleRed", template = "2292d37f-7cb2-4458-83c6-1f2e48ffa23e" },
    { stat = "OBJ_Dye_WhiteBrown", template = "3336e3a5-0be1-407d-9c37-01536bb2e6c5" },
    { stat = "OBJ_Dye_BlackTeal", template = "94ef7170-1c1d-489a-9c18-55209d864e3a" },
    { stat = "OBJ_Dye_BlackGreen", template = "81512e6c-dbe4-451c-b5cc-7268656444c1" },
    { stat = "OBJ_Dye_Purple_04", template = "7ac1bb07-e494-42d2-bb8d-6bf9e553a52a" },
    { stat = "OBJ_Dye_WhiteBlack", template = "ffdb4490-cbaf-4eac-97f8-893564d7ead9" },
    { stat = "OBJ_Dye_Purple_03", template = "5adba582-b552-4850-9be9-c6e28f656675" },
    { stat = "OBJ_Dye_BluePurple", template = "83cde47b-9e15-4ea5-98f4-4efd9ce93861" },
    { stat = "OBJ_Dye_IceCream_04", template = "43da55c8-55b7-41c6-9a44-3dd6843875f8" },
    { stat = "OBJ_Dye_IceCream_03", template = "2cd56a6a-35bb-417c-9eb6-d78bbe73d3cc" },
    { stat = "OBJ_Dye_Pink", template = "48a27277-7c18-49fe-9124-899919e162bc" },
    { stat = "OBJ_Dye_GreenPink", template = "78f41a7b-4742-419d-a0ac-b9a90a9e198e" },
    { stat = "OBJ_Dye_GreenSwamp", template = "a13f6fad-bca8-40c0-b5b1-592832c73050" },
    { stat = "OBJ_Dye_RedWhite", template = "f42e3c96-e622-4d3a-97da-ce5a939feb3c" },
    { stat = "OBJ_Dye_RoyalBlue", template = "17f6e66e-1c23-41d2-9370-3bd9a5a90b4a" },
    { stat = "OBJ_Dye_Azure", template = "eedbd9cc-5072-47fd-90a6-36a24c435620" },
    { stat = "OBJ_Dye_IceCream", template = "23899dcd-8f27-4144-b29d-ae61eaacd8c3" },
    { stat = "OBJ_Dye_Purple", template = "808cd643-ac73-415c-8ed8-0a81b8b71dd8" },
    { stat = "DLC_OBJ_Dye_Larian", template = "dfb0bd5d-e4ed-4bd3-bcfe-45195260e7dc" },
    { stat = "OBJ_Dye_Green_02", template = "ea46200e-001b-45a1-b1d9-20920e747ba2" },
    { stat = "OBJ_Dye_Maroon", template = "10e79bfb-c448-4af4-a153-bf3d19f83c62" },
    { stat = "OBJ_Dye_BlackPink", template = "db4761b2-cce8-4d6d-86ec-5cf0924a5f4c" },
    { stat = "OBJ_Dye_RichRed", template = "51cd678b-6a27-490d-b4d1-17cc89a32e40" },
    { stat = "OBJ_Dye_IceCream_02", template = "0e339e21-df58-4e46-a263-e91d4ed19dc9" },
    { stat = "OBJ_Dye_WhiteRed", template = "1d0d3883-6196-4ccd-8a49-8e4fb84f6c6b" },
}

local function out(msg)
  ConsoleToolkit.out(msg)
end

local function resolve_target(character_id)
  return character_id or GetHostCharacter()
end

local function normalized_count(count, default_count)
  local value = tonumber(count)
  if value == nil then
    return default_count
  end

  value = math.floor(value)
  if value < 1 then
    return default_count
  end

  return value
end

local function grant_templates(label, templates, character_id, dry_run, show_notification, default_count)
  local target = resolve_target(character_id)
  if dry_run == nil then
    dry_run = false
  end
  if show_notification == nil then
    show_notification = 1
  end

  local touched = 0
  local total_quantity = 0
  for _, item in ipairs(templates) do
    local item_count = item.count or default_count or 1
    if dry_run then
      out(string.format("[DRY][%s] would add %s x%d (%s) to %s", label, item.stat, item_count, item.template, tostring(target)))
    else
      Osi.TemplateAddTo(item.template, target, item_count, show_notification)
      out(string.format("[OK][%s] added %s x%d to %s", label, item.stat, item_count, tostring(target)))
    end
    touched = touched + 1
    total_quantity = total_quantity + item_count
  end

  out(string.format(
    "Done | set=%s | target=%s | dry_run=%s | touched=%d | total_quantity=%d",
    label,
    tostring(target),
    tostring(dry_run),
    touched,
    total_quantity
  ))
end

local function dye_templates(count, remover_count)
  local dye_count = normalized_count(count, 10)
  local dye_remover_count = normalized_count(remover_count, 20)
  local result = {}

  for _, item in ipairs(DYES) do
    result[#result + 1] = {
      stat = item.stat,
      template = item.template,
      count = item.stat == "OBJ_Dye_Remover" and dye_remover_count or dye_count,
    }
  end

  return result
end

function ConsoleToolkit.items.help()
  out("=== ConsoleToolkit.items Commands ===")
  out("Mods.ConsoleToolkit.items.grant_prologue_camp_clothing(<character_uuid>, <dry_run>, <show_notification>)")
  out("Mods.ConsoleToolkit.items.grant_epilogue_camp_clothing(<character_uuid>, <dry_run>, <show_notification>)")
  out("Mods.ConsoleToolkit.items.grant_digital_deluxe_clothing(<character_uuid>, <dry_run>, <show_notification>)")
  out("Mods.ConsoleToolkit.items.grant_twitch_clothing(<character_uuid>, <dry_run>, <show_notification>)")
  out("Mods.ConsoleToolkit.items.grant_scrolls(<count>, <character_uuid>, <dry_run>, <show_notification>)")
  out("Mods.ConsoleToolkit.items.grant_arrows(<count>, <character_uuid>, <dry_run>, <show_notification>)")
  out("Mods.ConsoleToolkit.items.grant_dyes(<count>, <remover_count>, <character_uuid>, <dry_run>, <show_notification>)")
  out("Tip: character_uuid defaults to GetHostCharacter(); dry_run defaults to false; show_notification defaults to 1.")
  out("Default counts: scrolls=1, arrows=50, dyes=10, dye remover=20.")
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

function ConsoleToolkit.items.grant_scrolls(count, character_id, dry_run, show_notification)
  grant_templates("Scrolls", SCROLLS, character_id, dry_run, show_notification, normalized_count(count, 1))
end

function ConsoleToolkit.items.grant_arrows(count, character_id, dry_run, show_notification)
  grant_templates("Arrows", ARROWS, character_id, dry_run, show_notification, normalized_count(count, 50))
end

function ConsoleToolkit.items.grant_dyes(count, remover_count, character_id, dry_run, show_notification)
  grant_templates("Dyes", dye_templates(count, remover_count), character_id, dry_run, show_notification)
end

out("Mods.ConsoleToolkit.items loaded. Run Mods.ConsoleToolkit.items.help()")

function RemoveEnemyOfJustice()
  for i,v in ipairs(Osi.DB_CRIME_GuardKiller:Get(nil,nil,nil,nil,nil,nil,nil)) do CrimeSuspend(v[7]) print(v[7]) end
  Osi.RemoveStatus(GetHostCharacter(), "GB_GUARDKILLER")
  Osi.DB_CRIME_GuardKiller:Delete(nil, nil, nil, nil, nil, nil, nil)
end

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, cause, storyActionID)
  if status == "GB_GUARDKILLER" then
    RemoveEnemyOfJustice()
  end
end)

Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(levelName, isEditorMode)
  RemoveEnemyOfJustice()
end)

print('enemy of justice fxxkoff loaded')

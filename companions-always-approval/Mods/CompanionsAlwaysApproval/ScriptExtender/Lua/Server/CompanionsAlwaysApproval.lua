Ext.Osiris.RegisterListener("ApprovalRatingChangeAttempt", 5, "before", function(ratingOwner, ratedEntity, attemptedApprovalChange, clampedApprovalChange, newApproval)
  local delta = attemptedApprovalChange
  if delta < 0 then
    local positiveChange = math.abs(delta)
    Osi.ChangeApprovalRating(ratingOwner, ratedEntity, 0, positiveChange * 2)
  end
end)

print("companions always approval loaded")

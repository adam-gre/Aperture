-- CommandHandler.registerServerCommand("/god", function(ply, args)
--     local character = ply:GetControlledCharacter()

--     character:SetInvulnerable(not character:IsInvulnerable())
--     Server:SendChatMessage(ply, character:IsInvulnerable() and "God Enabled" or "God disabled")
-- end)

-- CommandHandler.registerServerCommand("/revive", function(ply, args)
--     local character = ply:GetControlledCharacter()
--     local oldpos = character:GetLocation()

--     character:Respawn()
--     character:SetLocation(Vector(oldpos.X, oldpos.Y, oldpos.Z + 50))
-- end)

Package:Require("/Modules/Jobs/Index.lua")
Package:Require("/Modules/CommandHandler/CommandHandler.lua")
Package:Require("/Modules/Database/Connection.lua")
Package:Require("/Modules/Economy/Player.lua")
Package:Require("/Modules/Economy/Methods.lua")
Package:Require("/Modules/Utils/Administration.lua")
Package:Require("/Modules/Utils/Utils.lua")

Player:Subscribe("Spawn", function(ply)

    -- Insert player if not exists in the DB
    dbConnection:execute(string.format( 'INSERT INTO playerdata(steamid, rpname) VALUES(%s, "%s");', dbConnection:escape(ply:GetAccountID()), dbConnection:escape(ply:GetAccountName()) ))

    -- Assign temp values to player to not punch the DB everytime
    for k, v in pairs(Aperture.getPData(ply:GetAccountID())) do
        ply:SetValue("ApertureVar::" .. k, v)
    end

    -- Creating character

    local instance = Character(Vector(123, 456, 789), Rotator(0, 0, 0), "NanosWorld::SK_Male")

    instance:AddSkeletalMeshAttached("shirt", "NanosWorld::SK_Shirt")
    instance:AddSkeletalMeshAttached("shirt", "NanosWorld::SK_Underwear")
    instance:AddSkeletalMeshAttached("pants", "NanosWorld::SK_Pants")
    instance:AddSkeletalMeshAttached("shoes", "NanosWorld::SK_Shoes_01")
    instance:AddStaticMeshAttached("hair", "NanosWorld::SM_Hair_Long", "hair_male")
    instance:AddStaticMeshAttached("hair", "NanosWorld::SM_Hair_Short", "hair_male")

    ply:Possess(instance)

    -- Restore the player's position
    local pos = Aperture.JsonToVector3(ply:GetValue("ApertureVar::position"))
    instance:SetLocation(pos)
end)

Character:Subscribe("UnPossessed", function( char, ply )
    Aperture.SyncData(ply, char)
    char:Destroy()
end)



-- Misc commands wich will be moved soon

CommandHandler.registerServerCommand("/id", function(ply, args)
    Server:SendChatMessage(ply, "Your ID is " .. ply:GetValue("id"))
end)

CommandHandler.registerServerCommand("/pos", function(ply, args)
    local char = ply:GetControlledCharacter()
    local x, y, z = char:GetLocation()

    Server:SendChatMessage(ply, string.format( "X: %s Y: %s Z: %s", x, y ,z ))

end)

CommandHandler.registerServerCommand("/steamid", function(_, args)
    if args[1] == nil then Package:Log("You must specify an id")return end
    local lookupid = Aperture.idToSteamId(args[1])
    if lookupid == -1 then Package:Log("Cannot fint this user in the database !")return end

    Package:Log("The steamid of the id " .. args[1] .. " is " .. lookupid)
end)

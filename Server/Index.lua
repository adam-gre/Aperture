Package:Require("/Modules/CommandHandler/CommandHandler.lua")
Package:Require("/Modules/Jobs/Index.lua")
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
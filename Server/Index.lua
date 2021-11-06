Package.Require("/Modules/CommandHandler/CommandHandler.lua")
Package.Require("/Modules/Jobs/Index.lua")
Package.Require("/Modules/Database/Connection.lua")
Package.Require("/Modules/Economy/Player.lua")
Package.Require("/Modules/Economy/Methods.lua")
Package.Require("/Modules/Utils/Administration.lua")
Package.Require("/Modules/Utils/Utils.lua")

Player.Subscribe("Spawn", function(ply)

    Package.Log(ply:GetSteamID())
    Package.Log(ply:GetAccountName())

    -- Insert player if not exists in the DB
    local query = string.format( 'INSERT INTO playerdata(`steamid`, `rpname`) VALUES("%s", "%s");', dbConnection:escape(ply:GetSteamID()), dbConnection:escape(ply:GetAccountName()))
    dbConnection:execute(query)

    Package.Log(query)
    NanosUtils.Dump(Aperture.getPData(ply:GetSteamID()))

    -- Assign temp values to player to not punch the DB everytime
    for k, v in pairs(Aperture.getPData(ply:GetSteamID())) do
        ply:SetValue("ApertureVar::" .. k, v, true)
        Package.Log("ApertureVar::" .. k..": ".. v)
    end

    -- Creating character

    local instance = Character(Vector(123, 456, 789), Rotator(0, 0, 0), "nanos-world::SK_Male")

    instance:AddSkeletalMeshAttached("shirt", "nanos-world::SK_Shirt")
    instance:AddSkeletalMeshAttached("shirt", "nanos-world::SK_Underwear")
    instance:AddSkeletalMeshAttached("pants", "nanos-world::SK_Pants")
    instance:AddSkeletalMeshAttached("shoes", "nanos-world::SK_Shoes_01")
    instance:AddStaticMeshAttached("hair", "nanos-world::SM_Hair_Long", "hair_male")
    instance:AddStaticMeshAttached("hair", "nanos-world::SM_Hair_Short", "hair_male")

    ply:Possess(instance)

    -- Restore the player's position
    local position = Aperture.JsonToVector3(ply:GetValue("ApertureVar::position"))
    instance:SetLocation(position)
end)

Character.Subscribe("UnPossessed", function( char, ply )
    Aperture.SyncData(ply, char)
    char:Destroy()
end)
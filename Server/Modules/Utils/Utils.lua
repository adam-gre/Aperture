function Aperture.idToSteamId(id)
    Package:Log("ID is: " .. id)
    local cursor = dbConnection:execute("SELECT steamid FROM playerdata WHERE id='" .. id .. "';")

    if cursor:numrows() ~= 0 then
        return cursor:fetch({}, "a").steamid
    end

    return -1
end

function Aperture.getPData(steamid)

    local cursor = dbConnection:execute("SELECT * FROM playerdata WHERE steamid='" .. steamid .. "';")

    return cursor:fetch({}, "a")
end

function Aperture.Vector3ToJson(loc)
    local pos = {
        x = loc.X,
        y = loc.Y,
        z = loc.Z,
    }
    return JSON.stringify(pos)
end

function Aperture.JsonToVector3( str )
    local pos = JSON.parse(str)
    
    return Vector(pos.x, pos.y, pos.z)
end

function Aperture.SyncData( ply, char )
    local vars =  {
        rpname = ply:GetValue("ApertureVar::rpname"),
        money = ply:GetValue("ApertureVar::money"),
        position = Aperture.Vector3ToJson(char:GetLocation()),
    }

    local query = string.format( [[UPDATE playerdata
    SET rpname = '%s',
        money = %s,
        position = '%s'
    WHERE steamid = '%s';]], vars.rpname, vars.money, vars.position, ply:GetSteamID() )
    Package.Log(query)
    dbConnection:execute(query)
end

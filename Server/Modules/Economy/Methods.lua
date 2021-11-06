function Aperture.addMoney( ply, amount, type )
    local money = ply:GetValue("ApertureVar::money") + math.floor( amount )

    if money > 0 then
        ply:SetValue("ApertureVar::money", money)
        Aperture.addTransaction(ply, amount, type)
        Aperture.SyncData(ply)
        return true
    end

    ply:SetValue("ApertureVar::money", 0)
end


function Aperture.deductMoney( ply, amount, type )
    if ply:GetValue("ApertureVar::money") > tonumber(amount) then
        local money = ply:GetValue("ApertureVar::money") - math.floor( amount )
        ply:SetValue("ApertureVar::money", money)
        Aperture.addTransaction(ply, -amount, type)
        Aperture.SyncData(ply)
        return true
    else 
        return "Insufficient funds!"
    end
end

function Aperture.transferMoney( ply_sender, ply_recipient )
end

function Aperture.addTransaction(ply, amount, type)
    local query = string.format( [[INSERT INTO transactions
        (
            `steamid`,
            `amount`,
            `reason`
        ) VALUES (
            '%s', 
            %s,
            '%s'

        )
    ;]], ply:GetSteamID(), amount, type )
    Package.Log(query)
    dbConnection:execute(query)
end
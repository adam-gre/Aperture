function Aperture.addMoney( ply, amount )
    local money = ply:GetValue("ApertureVar::money") + math.floor( amount )

    if money > 0 then
        ply:SetValue("ApertureVar::money", money)
        return
    end

    ply:SetValue("ApertureVar::money", 0)
end
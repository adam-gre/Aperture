CommandHandler.registerServerCommand("/money", function(ply, args)
    local money = ply:GetValue("ApertureVar::money")
    Server.SendChatMessage(ply, "You have <green>$" .. money .. "</> left on you")
end)

CommandHandler.registerServerCommand("/addmoney", function( ply, args )
    local transaction = Aperture.addMoney(ply, args[1], 'admin')
    if transaction == true then
        local money = ply:GetValue("ApertureVar::money")
        Server.SendChatMessage(ply, "You have <green>$" .. money .. "</> left on you")
    else
        Server.SendChatMessage(ply, transaction)
    end
end)

CommandHandler.registerServerCommand("/deductmoney", function( ply, args )
    local transaction = Aperture.deductMoney(ply, args[1], 'admin')
    if transaction == true then
        local money = ply:GetValue("ApertureVar::money")
        Server.SendChatMessage(ply, "You have <green>$" .. money .. "</> left on you")
    else
        Server.SendChatMessage(ply, transaction)
    end
end)
CommandHandler = {}
CommandHandler.Commands = CommandHandler.Commands or {}
CommandHandler.ChatSupressed = CommandHandler.ChatSupressed or {}

local function splitString(str)
    local strs = {}
    for v in string.gmatch(str, "%S+") do
        strs[#strs + 1] = v
    end

    return strs
end

Server.Subscribe("Chat", function(txt, ply)
    local split = splitString(txt)
    local cmd = table.remove(split, 1)


    if CommandHandler.Commands[string.lower(cmd)] then
        if not ply:IsValid() then return end
        CommandHandler.Commands[string.lower(cmd)](ply, split)
    end

    for _, v in pairs(CommandHandler.ChatSupressed) do
        if string.lower( cmd ) == v then
            return false
        end
    end
end)

CommandHandler.registerServerCommand = function(command, func, supressed)
    local command = string.lower( command )
    supressed = supressed == nil and true or supressed -- If not specified = true
    Package:Log("Command supressed: " ..tostring(supressed))
    if not CommandHandler.Commands[command] then
        CommandHandler.Commands[command] = func
        if supressed then table.insert( CommandHandler.ChatSupressed, command) end
    end
end


CommandHandler.registerServerCommand("/jobs", function( ply, args )
    for i = 1, #RPExtraTeams do
      Server.SendChatMessage(ply, RPExtraTeams[i].name)
    end
end, false)
CommandHandler = {}
CommandHandler.Commands = CommandHandler.Commands or {}

local function splitString(str)
    local strs = {}
    for v in string.gmatch(str, "%S+") do
        strs[#strs + 1] = v
    end

    return strs
end

Server:Subscribe("Chat", function(txt, ply)
    local split = splitString(txt)
    local cmd = table.remove(split, 1)

    if CommandHandler.Commands[string.lower(cmd)] then
        if not ply:IsValid() then return end
        CommandHandler.Commands[string.lower(cmd)](ply, split)
    end
end)

CommandHandler.registerServerCommand = function(command, func)
    if not CommandHandler.Commands[string.lower(command)] then
        CommandHandler.Commands[string.lower(command)] = func
    end
end

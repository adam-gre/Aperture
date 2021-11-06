local luasql = require("luasql.mysql")
local mysql = luasql.mysql()

dbConnection = mysql:connect("nanos_world", "nanos", "CekujEQA5aRE", "localhost", 3306) -- CHANGE THESE!

if not dbConnection or not dbConnection:ping() then
    Package.Log("[ Aperture ] Database connection failed...\n Maybe wrong credentials or SQL server rejected the connection\n Unloading package")
    Timer.SetTimeout(500, function()
        Server:UnloadPackage(Package:GetName())
    end)

else
    local playerdata = string.format( [[
        CREATE TABLE IF NOT EXISTS `playerdata` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `rpname` varchar(50) NOT NULL DEFAULT '',
        `money` int(11) NOT NULL DEFAULT 0,
        `steamid` varchar(50) NOT NULL DEFAULT '0',
        `position` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
        `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
        PRIMARY KEY (`id`),
        UNIQUE KEY `steamid` (`steamid`),
        UNIQUE KEY `rpname` (`rpname`)
    )
    ]] )
    dbConnection:execute(playerdata)

    local transactions = string.format( [[
        CREATE TABLE IF NOT EXISTS `transactions` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
        `steamid` varchar(50) NOT NULL DEFAULT '0',
        `amount` int(11) NOT NULL DEFAULT 0,
        `reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
        PRIMARY KEY (`id`)
    )
    ]] )
    dbConnection:execute(transactions)
    
    Package.Log("[ Aperture ] Database initialised")
end
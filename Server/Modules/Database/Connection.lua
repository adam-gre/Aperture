local luasql = require("luasql.mysql")
local mysql = luasql.mysql()

dbConnection = mysql:connect("aperture", "lexa", "lexa", "localhost", 3306)

if not dbConnection or not dbConnection:ping() then
    Package:Log("[ Aperture ] Database connection failed...\n Maybe wrong credentials or SQL server rejected the connection\n Unloading package")
    Timer:SetTimeout(500, function()
        Server:UnloadPackage(Package:GetName())
    end)

else
    Package:Log("Database - Connection etablished")
end

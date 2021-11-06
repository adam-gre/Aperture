local luasql = require("luasql.mysql")
local mysql = luasql.mysql()

dbConnection = mysql:connect("nanos_world", "nanos", "CekujEQA5aRE", "localhost", 3306) -- CHANGE THESE!

if not dbConnection or not dbConnection:ping() then
    Package.Log("[ Aperture ] Database connection failed...\n Maybe wrong credentials or SQL server rejected the connection\n Unloading package")
    Timer.SetTimeout(500, function()
        Server:UnloadPackage(Package:GetName())
    end)

else
    Package.Log("[ Aperture ] Database initialised")
end

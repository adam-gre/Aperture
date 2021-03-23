RPExtraTeams = {}

local function istable(tbl)
  if type(tbl) == "table" then return true end
  return false
end

function Aperture.addJob(name, config)
  assert(type(name) == "string", "Aperture - Job name must be a string !")
  assert(type(config) == "table", "Aperture - Failed to load the job configuration: " ..name.. " !")
  local Team = #RPExtraTeams + 1

  RPExtraTeams[Team] = {
    ["name"] = name,
    ["description"] = config.description or "Not specified",
    ["salary"] = config.salary or Aperture.Config.normalSalary,
    ["weapons"] = config.weapons or Aperture.Config.defaultWeapons,
  }

  return Team
end

function Aperture.jobExists(value)
    for k, v in pairs(RPExtraTeams) do
      if v.name == value then return true end
    end
    return false
end

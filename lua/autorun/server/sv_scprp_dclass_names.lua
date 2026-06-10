-- D-Class numbers for DarkRP / SCP-RP
-- https://github.com/zarasahara/scprp-dclass-names
-- requires allowrpnames = true

-- put your own D-Class jobs here (TEAM_ names from your jobs.lua, as strings)
local DCLASS_JOBS = {
    "TEAM_DCLASS",
    -- "TEAM_DCLASS_VETERAN",
    -- "TEAM_DCLASS_MEDIC",
}

local function isDClass(teamID)
    for _, name in ipairs(DCLASS_JOBS) do
        if _G[name] == teamID then return true end
    end
    return false
end

local function genNumber()
    local n
    repeat
        n = math.random(10000, 99999)
        local taken = false
        for _, p in ipairs(player.GetAll()) do
            if p.DClassNumber == n then taken = true break end
        end
    until not taken
    return n
end

local function stripPrefix(name)
    return string.gsub(name or "", "^D%-%d+%s*", "")
end

local function applyPrefix(ply)
    if not IsValid(ply) or not ply.DClassNumber then return end
    local current = ply:getDarkRPVar("rpname") or ply:Nick()
    local wanted = "D-" .. ply.DClassNumber .. " " .. stripPrefix(current)
    if current ~= wanted then
        ply:setDarkRPVar("rpname", wanted)
    end
end

hook.Add("OnPlayerChangedTeam", "DClassNummer", function(ply, oldTeam, newTeam)
    if isDClass(newTeam) then
        if not ply.DClassNumber then
            ply.DClassNumber = genNumber()
        end
        timer.Simple(0, function() applyPrefix(ply) end)
    elseif ply.DClassNumber then
        ply.DClassNumber = nil
        local current = ply:getDarkRPVar("rpname")
        if current then
            ply:setDarkRPVar("rpname", stripPrefix(current))
        end
    end
end)

-- darkrp sets the name AFTER this hook fires, hence the timer
hook.Add("onPlayerChangedName", "DClassNummerPrefix", function(ply, oldName, newName)
    if not ply.DClassNumber then return end
    timer.Simple(0, function() applyPrefix(ply) end)
end)

-- in case someone joins directly as dclass with a saved job
hook.Add("PlayerInitialSpawn", "DClassNummerSpawn", function(ply)
    timer.Simple(1, function()
        if not IsValid(ply) then return end
        if isDClass(ply:Team()) and not ply.DClassNumber then
            ply.DClassNumber = genNumber()
            applyPrefix(ply)
        end
    end)
end)

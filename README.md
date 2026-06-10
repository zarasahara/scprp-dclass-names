# D-Class Numbers

Small serverside addon for DarkRP / SCP-RP servers in Garry's Mod. Players switching to a D-Class job automatically get a random five digit number as a name prefix, e.g. `D-83421 John Doe`.

The actual RP name is kept and can still be changed with `/rpname` as usual, the prefix is reapplied automatically afterwards. When the player leaves the job, the prefix is removed.

## Requirements

- DarkRP (or an SCP-RP gamemode based on DarkRP)
- RP names have to be enabled:

```lua
GM.Config.allowrpnames = true
```

You can find this setting in darkrpmodification under `lua/darkrp_config/config.lua`.

## Installation

1. Copy the folder into `garrysmod/addons/`
2. Add your own D-Class jobs (see below)
3. Restart the server or change the map

## Configuration

At the top of `lua/autorun/server/sv_scprp_dclass_names.lua` you'll find the jobs that count as D-Class:

```lua
local DCLASS_JOBS = {
    "TEAM_DCLASS",
    -- "TEAM_DCLASS_VETERAN",
    -- "TEAM_DCLASS_MEDIC",
}
```

Put in the `TEAM_` names from your `jobs.lua`, exactly what you write before `DarkRP.createJob(...)`. Important: as strings in quotes, so the load order of the files doesn't matter.

## Behavior

- The number is rolled once per session and stays the same when switching between multiple D-Class jobs
- Numbers are unique among currently connected players
- After a reconnect the player gets a new number
- Survives death and respawn just fine

## Known limitations

The number is not stored permanently. If you want that, you can build a SteamID mapping into `genNumber()` and store it in a file or via SQL.

---

Code written by AI, directed, tested and maintained by a human.

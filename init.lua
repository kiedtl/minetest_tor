tor = { utils = {}, logic = {}, materials = {} }
local modpath = minetest.get_modpath("tor") .. "/"

dofile(modpath .. "utils.lua")
dofile(modpath .. "logic.lua")
dofile(modpath .. "materials.lua")

print("[OK] Tor")

local logic = tor.logic;

function logic.on_blast(coord, base_intensity, damage_type)
    local me = minetest.get_node_or_nil(coord)
    if me == nil then return end -- I could swear "foo or return" worked 3 years ago :P
    local def = minetest.registered_nodes[me.name]

    local armor = def.spacecannon_armor or {}
    local damage_type = damage_type or "thermal"
    local intensity = math.floor(math.random(base_intensity))
    local reduced_intensity = intensity * (armor[damage_type] or 100) / 100

    local meta = minetest.get_meta(coord)
    local integrity = meta:get_float("integrity") - reduced_intensity

    print("Intensity: " .. intensity .. "; reduced: " .. reduced_intensity)
    print("Integrity: " .. meta:get_float("integrity") .. "; " .. integrity)

    if integrity <= 0 then
        -- Copied from spacecannon's source.
        minetest.set_node(coord, { name = "air" })
        local itemstacks = minetest.get_node_drops(me.name)
        for _, itemname in ipairs(itemstacks) do
            if math.random(5) == 5 then
                -- chance drop
                minetest.add_item(coord, itemname)
            end
        end
    else
        meta:set_float("integrity", integrity)
    end
end

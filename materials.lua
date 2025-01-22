-- TODO:
-- x Subspace Ion Thruster
-- * Subspace Antigrav
-- x Composite Structure
-- * Borium-reinforced Glass
-- x Borium-reinforced Cable
-- x Atomic Flux Cell
-- * Electric Routing Device
-- * Spacecannon
--   * Pass damage type to on_blast
--   * spacecannon_armor support
--   * minetest.rotate_node

-- Engines. Flavor.
-- Non-idling demand is higher, but we don't tell the player that.
--
minetest.register_node("tor:subspace_ion_thruster", {
    description = "Subspace Ion Thruster",
    drawtype = "mesh",
    mesh = "tor_subspace_ion_thruster.obj",
    tiles = { "tor_subspace_ion_thruster.png" },
    groups = { cracky = 2, oddly_breakable_by_hand = 1, technic_hv = 1, technic_machine = 1 },
    paramtype2 = "facedir",
    legacy_facedir_simple = true, -- No clue what this is for
    spacecannon_armor = { kinetic = 90, shearing = 90 },
    spacecannon_resilience = 3,
    drop = "tor:subspace_ion_thruster",
    on_place = minetest.rotate_node,
    connects_to = {"group:technic_hv_cable"},
    -- Minetest engine is too retarded to flip these as needed for when the node
    -- is rotated. So we just allow connections from any side.
    --connect_sides = {"bottom"},
    connect_sides = {"bottom", "top", "left", "right", "front", "back"},
    on_construct = function(coord)
        local meta = minetest.get_meta(coord)
        meta:set_int("HV_EU_demand", 60)
        meta:set_int("HV_EU_input", 0)
        meta:set_string("infotext", "")
    end,
    technic_run = function(coord)
        local meta = minetest.get_meta(coord)
        local eu_input = meta:get_int("HV_EU_input")
        local demand = meta:get_int("HV_EU_demand")

        if eu_input >= demand then
            technic.swap_node(coord, "tor:subspace_ion_thruster_active")
            return
        end

        local infotext =
            "Power: " .. eu_input .. "/" .. demand .. "\n" ..
            "Unpowered.\n"
        meta:set_string("infotext", infotext)
    end,
})
minetest.register_node("tor:subspace_ion_thruster_active", {
    description = "Subspace Ion Thruster (Idling)",
    drawtype = "mesh",
    mesh = "tor_subspace_ion_thruster.obj",
    tiles = { "tor_subspace_ion_thruster_active.png" },
    groups = { cracky = 2, oddly_breakable_by_hand = 1, technic_hv = 1, technic_machine = 1 },
    light_source = 12,
    paramtype = "light",
    paramtype2 = "facedir",
    legacy_facedir_simple = true, -- No clue what this is for
    spacecannon_armor = { kinetic = 90, shearing = 90 },
    spacecannon_resilience = 3,
    drop = "tor:subspace_ion_thruster",
    on_place = minetest.rotate_node,
    connects_to = {"group:technic_hv_cable"},
    -- Minetest engine is too retarded to flip these as needed for when the node
    -- is rotated. So we just allow connections from any side.
    --connect_sides = {"bottom"},
    connect_sides = {"bottom", "top", "left", "right", "front", "back"},
    technic_disabled_machine_name = "tor:subspace_ion_thruster",
    on_construct = function(coord)
        local meta = minetest.get_meta(coord)
        meta:set_int("HV_EU_demand", 200)
        meta:set_int("HV_EU_input", 0)
        meta:set_string("infotext", "")
    end,
    technic_run = function(coord)
        local meta = minetest.get_meta(coord)
        local eu_input = meta:get_int("HV_EU_input")
        local demand = meta:get_int("HV_EU_demand")

        if eu_input < demand then
            technic.swap_node(coord, "tor:subspace_ion_thruster")
            return
        end

        local infotext =
            "Power: " .. eu_input .. "/" .. demand .. "\n" ..
            "Idling (engine is disabled remotely).\n"
        meta:set_string("infotext", infotext)
    end,
})
technic.register_machine("HV", "tor:subspace_ion_thruster", technic.receiver)
technic.register_machine("HV", "tor:subspace_ion_thruster_active", technic.receiver)

-- Power.
local AFC_SUPPLY         = 1500
minetest.register_node("tor:atomic_flux_cell", {
    description = "Atomic Flux Cell",
    drawtype = "mesh",
    mesh = "tor_atomic_flux_cell.obj",
    tiles = { "tor_atomic_flux_cell.png" },
    groups = {
        cracky = 2, oddly_breakable_by_hand = 2,
        technic_hv = 1, technic_machine = 1, radioactive = 1,
    },
    light_source = 5,
    paramtype = "light",
    paramtype2 = "facedir",
    -- Deliberately didn't put any resilience
    drop = "tor:atomic_flux_cell",
    connects_to = {"group:technic_hv_cable"},
    connect_sides = {"bottom", "back" },
    on_construct = function(coord)
        local meta = minetest.get_meta(coord)
        meta:set_int("HV_EU_supply", AFC_SUPPLY)
    end,
    technic_run = function(coord)
        local meta = minetest.get_meta(coord)
        local infotext =
            "Tor Atomic Flux Cell (active)\n" ..
            "Generating: " .. AFC_SUPPLY
        meta:set_string("infotext", infotext)
    end,
})
technic.register_machine("HV", "tor:atomic_flux_cell", technic.producer)

-- Utility nodes.
technic.register_cable("tor:borium_hv_cable", {
    description = "Borium-reinforced HV Cable",
    tiles = { "tor_borium_hv_cable.png" },
    groups = { cracky = 2, technic_hv_cable = 1 },
    spacecannon_armor = { thermal = 75, kinetic = 60, shearing = 90 },
    drop = "tor:borium_hv_cable",
    connects_to = {"group:technic_hv_cable", "group:technic_hv", "group:technic_all_tiers"},
    on_construct = function(coord)
        local meta = minetest.get_meta(coord)
        meta:set_float("integrity", 4)
        technic.place_network_node(coord, {"HV"}, "tor:borium_hv_cable")
    end,
    on_destruct = function(coord)
        technic.remove_network_node(coord, {"HV"}, "tor:borium_hv_cable")
    end,
    on_blast = tor.logic.on_blast,

    -- register_table specific stuff
    paramtype = "", -- Otherwise this function sets it to "light"
    sunlight_propagates = false,
    size = 0.5,
    tier = "HV",
    wield_image = false,
    inventory_image = false,
})

-- Basic armor.
minetest.register_node("tor:borium_arm", {
    description = "Borium Plating",
    tiles = { "tor_borium_arm.png" },
    drop = "tor:borium_arm",
    groups = { cracky = 1 },
    spacecannon_armor = { thermal = 50, kinetic = 40, shearing = 70 },
    on_construct = function(coord)
        local meta = minetest.get_meta(coord)
        meta:set_float("integrity", 8)
    end,
    on_blast = tor.logic.on_blast,
})

minetest.register_node("tor:lgt_borium_arm", {
    description = "Lgt. Borium Plating",
    tiles = { "tor_lgt_borium_arm.png" },
    drop = "tor:lgt_borium_arm",
    groups = { cracky = 1 },
    spacecannon_armor = { thermal = 70, kinetic = 40, shearing = 70 },
    on_construct = function(coord)
        local meta = minetest.get_meta(coord)
        meta:set_float("integrity", 5)
    end,
    on_blast = tor.logic.on_blast,
})

-- Structural building blocks.
minetest.register_node("tor:composite_block", {
    description = "Tor Composite Block",
    tiles = { "tor_composite_block.png" },
    drop = "tor:composite_block",
    groups = { cracky = 2 },
})

-- Not needed for drone, will complete later.
--
--minetest.register_node("tor:borium_regen", {
--    description = "Borium Energy Diffuser",
--    tiles = {
--        "tor_borium_regen.png",
--        "tor_borium_regen.png",
--        "tor_borium_regen.png",
--        "tor_borium_regen.png",
--        "tor_borium_regen.png",
--        "tor_borium_regen.png",
--    },
--    drop = "tor:borium_regen",
--    groups = { cracky = 1 },
--    spacecannon_armor = { th = 80, ki = 80 },
--    paramtype2 = "facedir",
--})
--technic.register_machine("HV", "tor:borium_regen", technic:receiver)

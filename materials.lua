-- TODO:
-- * Subspace Nuclear Thruster
-- * Subspace Nuclear Steering
-- * Composite Structure
-- * Borium-reinforced Glass
-- * Spacecannon
--   * Pass damage type to on_blast

-- Basic armor.
minetest.register_node("tor:borium_arm", {
    description = "Borium Plating",
    tiles = {
        "tor_borium_arm.png",
        "tor_borium_arm.png",
        "tor_borium_arm.png",
        "tor_borium_arm.png",
        "tor_borium_arm.png",
        "tor_borium_arm.png",
    },
    drop = "tor:borium_arm",
    groups = { cracky = 1 },
    spacecannon_armor = { thermal = 60, kinetic = 60 },
    on_construct = function(coord)
        local meta = minetest.get_meta(coord)
        meta:set_float("integrity", 8)
    end,
    on_blast = tor.logic.on_blast,
})

minetest.register_node("tor:lgt_borium_arm", {
    description = "Lgt. Borium Plating",
    tiles = {
        "tor_lgt_borium_arm.png",
        "tor_lgt_borium_arm.png",
        "tor_lgt_borium_arm.png",
        "tor_lgt_borium_arm.png",
        "tor_lgt_borium_arm.png",
        "tor_lgt_borium_arm.png",
    },
    drop = "tor:lgt_borium_arm",
    groups = { cracky = 1 },
    spacecannon_armor = { thermal = 70, kinetic = 70 },
    on_construct = function(coord)
        local meta = minetest.get_meta(coord)
        meta:set_float("integrity", 5)
    end,
    on_blast = tor.logic.on_blast,
})

-- Structural building blocks.
minetest.register_node("tor:composite_block", {
    description = "Tor Composite Block",
    tiles = {
        "tor_composite_block.png",
        "tor_composite_block.png",
        "tor_composite_block.png",
        "tor_composite_block.png",
        "tor_composite_block.png",
        "tor_composite_block.png",
    },
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
--})
--technic.register_machine("HV", "tor:borium_regen", technic:receiver)

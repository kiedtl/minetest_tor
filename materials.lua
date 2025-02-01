-- TODO (drones):
-- x Subspace Ion Thruster
-- * Subspace Antigrav
--   * Superheated plasma
--   * Plasma
-- x Composite Structure
-- x Borium-reinforced Cable
-- x Atomic Flux Cell
-- x Lpw. Energy Well
-- x Lpw. Intelligence Center
-- x Antenna (damaged)
-- * Signal regenerator (damaged)
-- * Optical array (damaged)
-- x Quantum entanglement comms
-- * Escort
--
-- TODO (garrisons):
-- * Ultra high voltage (UHV) tier
--   * Cables, reinforced cable
--   * Supply converter (for player)
--
-- TODO (misc):
-- * Spacecannon
--   * Pass damage type to on_blast
--   * spacecannon_armor support
--   * minetest.rotate_node

local utils = tor.utils

-- Engines and other flavor nodes.
-- Non-idling engine demand is higher, but we don't tell the player that.
--
minetest.register_node("tor:subspace_ion_thruster", {
    description = "Subspace Ion Thruster (alien)",
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
    description = "Subspace Ion Thruster (Idling) (alien)",
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

minetest.register_node("tor:entangle_device", {
    description = "Qntm Entanglement Comms Unit (alien)",
    drawtype = "mesh",
    mesh = "tor_entangle_device.obj",
    tiles = { "digtron_plate.png" },
    groups = { cracky = 2, oddly_breakable_by_hand = 2, technic_lv = 1, technic_machine = 1 },
    drop = "tor:entangle_device",
    connects_to = {"group:technic_lv_cable"},
    connect_sides = {"bottom"},
    on_construct = function(coord)
        local meta = minetest.get_meta(coord)
        meta:set_int("LV_EU_demand", 10)
        minetest.add_entity(coord, "tor:entangle_containment")
    end,
    on_destruct = function(coord)
        utils.map_child_entity(coord, "tor:entangle_containment", function(obj) obj:remove() end)
    end,
    technic_run = function(coord)
        local meta = minetest.get_meta(coord)
        local eu_input = meta:get_int("LV_EU_input")
        local demand = meta:get_int("LV_EU_demand")

        if eu_input >= demand then
            technic.swap_node(coord, "tor:entangle_device_active")
            utils.map_child_entity(coord, "tor:entangle_containment",
                function(obj) obj:get_luaentity():make_spinny() end)
            return
        end

        local infotext =
            "Quantum Entanglement Communications Unit\n" ..
            "Power: " .. eu_input .. "/" .. demand .. "\n" ..
            "Unpowered.\n"
        meta:set_string("infotext", infotext)
    end,
})
minetest.register_node("tor:entangle_device_active", {
    description = "Qntm Entanglement Comms Unit (alien)",
    drawtype = "mesh",
    mesh = "tor_entangle_device.obj",
    tiles = { "digtron_plate.png" },
    groups = { cracky = 2, oddly_breakable_by_hand = 2, technic_lv = 1, technic_machine = 1 },
    drop = "tor:entangle_device",
    light_source = 5,
    paramtype = "light",
    connects_to = {"group:technic_lv_cable"},
    connect_sides = {"bottom"},
    technic_disabled_machine_name = "tor:entangle_device",
    on_destruct = function(coord)
        utils.map_child_entity(coord, "tor:entangle_containment", function(obj) obj:remove() end)
    end,
    technic_on_disable = function(coord)
        utils.map_child_entity(coord, "tor:entangle_containment",
            function(obj) obj:get_luaentity():make_unspinny() end)
    end,
    technic_run = function(coord)
        local meta = minetest.get_meta(coord)
        local eu_input = meta:get_int("LV_EU_input")
        local demand = meta:get_int("LV_EU_demand")

        if eu_input < demand then
            technic.swap_node(coord, "tor:entangle_device")
            return
        end

        local infotext =
            "Quantum Entanglement Communications Unit\n" ..
            "Power: " .. eu_input .. "/" .. demand .. "\n\n" ..
            "Cannot connect to remote control node: Timed out.\n" ..
            "Last connection: 4 days, 9 months, 1128 years ago."

        meta:set_string("infotext", infotext)
    end,
})
minetest.register_entity("tor:entangle_containment", {
    initial_properties = {
        visual = "mesh",
        mesh = "tor_entangle_containment.glb",
        textures = { "tor_entangle_containment.png" },
        physical = false,
        collide_with_objects = false,
        pointable = false,
    },
    on_activate = function(self, _staticdata) self:make_unspinny() end,
    make_spinny = function(self)
        self.object:set_animation({x = 0, y = 72}, 1.0, 0, true)
        self.object:set_properties({glow = 10})
    end,
    make_unspinny = function(self)
        self.object:set_animation({x = 0, y = 72}, 0.1, 5, true)
        self.object:set_properties({glow = 0})
    end,
})
technic.register_machine("LV", "tor:entangle_device", technic.receiver)
technic.register_machine("LV", "tor:entangle_device_active", technic.receiver)

local D_LPW_INTELLIGENCE_CELL, D_LPW_INTELLIGENCE_CELL_ACTIVATED = utils.technify(
    "tor:lpw_intelligence_cell",
    {
        description = "Lpw. Intelligence Cell (broken) (alien)",
        tiles = {
            "tor_lpw_intelligence_cell_top.png",
            "tor_lpw_intelligence_cell_bottom.png^tor_cable_overlay.png",
            "tor_lpw_intelligence_cell_side.png",
            "tor_lpw_intelligence_cell_side.png",
            "tor_lpw_intelligence_cell_bottom.png^tor_cable_overlay.png",
            "tor_lpw_intelligence_cell_front.png",
        },
        groups = { cracky = 3, oddly_breakable_by_hand = 3 },
        drop = "tor:lpw_intelligence_cell",
        connect_sides = {"bottom"},
        --on_place = minetest.rotate_node,
        paramtype2 = "facedir",
    },
    {
        tier = "LV", demand = 60,
        activated_light = 3,
        on_technic_run_enabled = function(coord, meta, eu_input)
            local infotext =
                "Low-powered Intelligence Cell (broken)\n" ..
                "Power: " .. eu_input .. "/" .. 60 .. "\n" ..
                "Catastrophic hardware failure."
            meta:set_string("infotext", infotext)
        end,
    },
    {
        tiles = {
            "tor_lpw_intelligence_cell_top.png",
            "tor_lpw_intelligence_cell_bottom.png^tor_cable_overlay.png",
            "tor_lpw_intelligence_cell_side.png",
            "tor_lpw_intelligence_cell_side.png",
            "tor_lpw_intelligence_cell_bottom.png^tor_cable_overlay.png",
            {
                name = "tor_lpw_intelligence_cell_front_active.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 32, aspect_h = 32,
                    length = 5.0,
                },
            },
        },
    }
)
minetest.register_node("tor:lpw_intelligence_cell", D_LPW_INTELLIGENCE_CELL)
minetest.register_node("tor:lpw_intelligence_cell_active", D_LPW_INTELLIGENCE_CELL_ACTIVATED)
technic.register_machine("LV", "tor:lpw_intelligence_cell", technic.receiver)
technic.register_machine("LV", "tor:lpw_intelligence_cell_active", technic.receiver)

local D_ANTENNA, D_ANTENNA_ACTIVATED = utils.technify(
    "tor:antenna",
    {
        description = "Local Antenna (broken) (alien)",
        tiles = { "tor_antenna.png" },
        use_texture_alpha = "clip",
        drawtype = "mesh",
        mesh = "tor_antenna.obj",
        groups = { cracky = 3, oddly_breakable_by_hand = 3 },
        drop = "tor:antenna",
        connect_sides = {"bottom"},
        paramtype2 = "facedir",
    },
    {
        tier = "LV", demand = 30,
        on_technic_run_enabled = function(coord, meta, eu_input)
            local infotext =
                "Antenna (broken)\n" ..
                "Power: " .. eu_input .. "/" .. 30 .. "\n" ..
                "Subantenna device error: I2C failed to initialize."
            meta:set_string("infotext", infotext)
        end,
    },
    { }
)
minetest.register_node("tor:antenna", D_ANTENNA)
minetest.register_node("tor:antenna_active", D_ANTENNA_ACTIVATED)
technic.register_machine("LV", "tor:antenna", technic.receiver)
technic.register_machine("LV", "tor:antenna_active", technic.receiver)

-- Power.
local AFC_MAX_SUPPLY = 1500
minetest.register_node("tor:atomic_flux_cell", {
    description = "Atomic Flux Cell (alien)",
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
        meta:set_int("HV_EU_supply", AFC_MAX_SUPPLY)
        meta:set_int("_counter", 1)
        meta:set_float("_variance", 0)
        meta:set_int("_mode", -1)
    end,
    -- For the varying power supply, we just have a cosine curve and add some
    -- noise to it. The noise is an accumulating value that either goes up or
    -- down depending on `mode`, which itself changes on a 60% chance.
    --
    technic_run = function(coord)
        local meta = minetest.get_meta(coord)
        local ctr = meta:get_int("_counter")
        local mode = meta:get_int("_mode")
        local var = meta:get_float("_variance")

        if math.random() > 0.6 then
            mode = math.random() > 0.5 and 1 or -1
        end

        var = var + (math.random() / 8 * mode)
        local val = (math.cos(math.rad(ctr)) + var) * 10
        local supply = math.min((AFC_MAX_SUPPLY * 3 / 4) + val, AFC_MAX_SUPPLY)

        local infotext =
            "Tor Atomic Flux Cell (active)\n" ..
            "Generating: " .. technic.EU_string(supply) .. " / " .. technic.EU_string(AFC_MAX_SUPPLY)
        meta:set_string("infotext", infotext)

        meta:set_int("HV_EU_supply", supply)
        meta:set_int("_counter", ctr + 1 % 360)
        meta:set_int("_mode", mode)
        meta:set_float("_variance", var)
    end,
})
technic.register_machine("HV", "tor:atomic_flux_cell", technic.producer)

local LEW_STORAGE = 4000
local LEW_CHARGE_R = 100
local LEW_DISCHARGE_R = 1000
local LEW_ANIM = { type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 6.0 }
minetest.register_node("tor:lpw_energy_well", {
    description = "Lpw. Energy Well (alien)",
    tiles = {
        { name = "tor_lpw_energy_well.png", animation = LEW_ANIM },
        { name = "tor_lpw_energy_well_static.png^tor_cable_overlay.png", animation = LEW_ANIM },
        { name = "tor_lpw_energy_well.png", animation = LEW_ANIM },
        { name = "tor_lpw_energy_well.png", animation = LEW_ANIM },
        { name = "tor_lpw_energy_well.png", animation = LEW_ANIM },
        { name = "tor_lpw_energy_well.png", animation = LEW_ANIM },
    },
    groups = {
        cracky = 2, oddly_breakable_by_hand = 2,
        technic_hv = 1, technic_machine = 1,
    },
    drop = "tor:lpw_energy_well",
    connects_to = {"group:technic_hv_cable"},
    connect_sides = {"bottom"},
    on_construct = function(coord)
        local meta = minetest.get_meta(coord)
        meta:set_int("HV_EU_supply", LEW_DISCHARGE_R)
        meta:set_int("_charge", 0)
    end,
    technic_run = function(coord, _node, _run_state, network)
        local meta = minetest.get_meta(coord)
        local eu_input = meta:get_int("HV_EU_input")
        local charge = meta:get_int("_charge")

        if eu_input >= 0 then
            charge = math.min(charge + eu_input, LEW_STORAGE)
        else
            charge = math.max(charge + eu_input, 0)
        end

        local supply = math.min(LEW_DISCHARGE_R, charge)
        local demand = math.min(LEW_CHARGE_R, LEW_STORAGE - charge)
        network:update_battery(charge, LEW_STORAGE, supply, demand)

        meta:set_int("HV_EU_demand", demand)
        meta:set_int("HV_EU_supply", supply)
        meta:set_int("_charge", charge)

        local infotext =
            "Low-power Energy Well\n" ..
            "Weeping Orthire fragment stability is at optimal levels.\n\n" ..
            "Storage: " .. technic.EU_string(charge) .. " / " .. technic.EU_string(LEW_STORAGE) .. "\n"
        meta:set_string("infotext", infotext)
    end,
})
technic.register_machine("HV", "tor:lpw_energy_well", technic.battery)

-- Utility nodes.
technic.register_cable("tor:borium_hv_cable", {
    description = "Borium-reinforced HV Cable (alien)",
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
    description = "Borium Plating (alien)",
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
    description = "Lgt. Borium Plating (alien)",
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
    description = "Tor Composite Block (alien)",
    tiles = { "tor_composite_block.png" },
    drop = "tor:composite_block",
    groups = { cracky = 2 },
})

-- Not needed for drone, will complete later.
--
--minetest.register_node("tor:borium_regen", {
--    description = "Borium Energy Diffuser (alien)",
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

-- Misc.
minetest.register_node("tor:superheated_plasma", {
    description = "Superheated Plasma",
    tiles = { "tor_plasma.png^[colorize:#F0D08099" },
    drop = "",
    drowning = 1,
    groups = { cracky = 2, not_in_creative_inventory = 1, igniter = 1 },
    paramtype2 = "light",
    light_source = minetest.LIGHT_MAX,
    sunlight_propagates = true,
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    drawtype = "glasslike",
    post_effect_color = { a = 20, r = 90, g = 35, b = 20 },
    alpha = 0.1,
    glow = 10,
    damage_per_second = 4 * 2, -- Same as lava

    on_construct = function(pos)
        minetest.get_node_timer(pos):start(math.random() * 4)
    end,

    on_timer = function(coord)
        minetest.set_node(coord, { name = "tor:plasma" })
    end
})

minetest.register_node("tor:plasma", {
    description = "Plasma",
    tiles = { "tor_plasma.png^[colorize:#D0905060" },
    drop = "",
    drowning = 1,
    groups = { cracky = 2, not_in_creative_inventory = 1, igniter = 1 },
    paramtype2 = "light",
    light_source = 8,
    sunlight_propagates = true,
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    drawtype = "glasslike",
    post_effect_color = { a = 20, r = 70, g = 25, b = 20 },
    alpha = 0.1,
    glow = 10,
    damage_per_second = 2 * 2,

    on_construct = function(pos)
        minetest.get_node_timer(pos):start(math.random() * 5)
    end,

    on_timer = function(coord)
        minetest.set_node(coord, { name = "air" })
    end
})

minetest.register_abm({
    label = "Superheated Plasma Flow",
    nodenames = {"tor:superheated_plasma"},
    interval = 0.5,
    chance = 1,

    action = function(coord, node)
        local neighbors = {
            -- Above
            { x = coord.x - 1, y = coord.y + 1, z = coord.z - 1 },
            { x = coord.x + 0, y = coord.y + 1, z = coord.z - 1 },
            { x = coord.x + 1, y = coord.y + 1, z = coord.z - 1 },
            { x = coord.x - 1, y = coord.y + 1, z = coord.z,    },
            { x = coord.x,     y = coord.y + 1, z = coord.z,    },
            { x = coord.x + 1, y = coord.y + 1, z = coord.z,    },
            { x = coord.x - 1, y = coord.y + 1, z = coord.z + 1 },
            { x = coord.x,     y = coord.y + 1, z = coord.z + 1 },
            { x = coord.x + 1, y = coord.y + 1, z = coord.z + 1 },
            -- Same y-level
            { x = coord.x - 1, y = coord.y,     z = coord.z - 1 },
            { x = coord.x + 0, y = coord.y,     z = coord.z - 1 },
            { x = coord.x + 1, y = coord.y,     z = coord.z - 1 },
            { x = coord.x - 1, y = coord.y,     z = coord.z,    },
            { x = coord.x,     y = coord.y,     z = coord.z,    },
            { x = coord.x + 1, y = coord.y,     z = coord.z,    },
            { x = coord.x - 1, y = coord.y,     z = coord.z + 1 },
            { x = coord.x,     y = coord.y,     z = coord.z + 1 },
            { x = coord.x + 1, y = coord.y,     z = coord.z + 1 },
        }
        local propagated = false
        for _, neighbor in ipairs(neighbors) do
            local node = minetest.get_node_or_nil(neighbor)
            if node and (node.name == "air" or node.name == "vacuum:vacuum") and math.random() > 0.4 then
                local name = "tor:plasma"
                if math.random() > 0.8 and not propagated then
                    name = "tor:superheated_plasma"
                    minetest.set_node(coord, { name = "air" })
                    propagated = true
                end
                minetest.set_node(neighbor, { name = name })
            end
        end
    end
})

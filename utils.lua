local utils = tor.utils

function shallow_clone(t)
  local u = {}
  for k, v in pairs(t) do u[k] = v end
  return u
end

-- Create an "activated" and "unactivated" version of a machine definition.
function utils.technify(nodename, def, params, active_override)
    local ltier = params.tier:lower()

    local on_technic_run_disabled = on_technic_run_disabled or function(coord, meta, eu_input)
        local infotext =
            "Power: " .. eu_input .. "/" .. params.demand .. "\n" ..
            "Unpowered.\n"
        meta:set_string("infotext", infotext)
    end

    local on_construct = on_construct or function(coord, meta) end

    local base_def = shallow_clone(def) -- Is this needed?
    base_def.groups["technic_" .. ltier] = 1
    base_def.groups.technic_machine = 1
    base_def.drop = nodename
    base_def.connects_to = {"group:technic_" .. ltier .. "_cable"}

    local unactivated = shallow_clone(base_def)
    unactivated.on_construct = function(coord)
        local meta = minetest.get_meta(coord)
        meta:set_int(params.tier .. "_EU_demand", params.demand)
        on_construct(coord, meta)
    end
    unactivated.technic_run = function(coord)
        local meta = minetest.get_meta(coord)
        local eu_input = meta:get_int("LV_EU_input")

        if eu_input >= params.demand then
            technic.swap_node(coord, nodename .. "_active")
            return
        end

        on_technic_run_disabled(coord, meta, eu_input)
    end

    local activated = shallow_clone(base_def)
    activated.light_source = params.activated_light
    activated.paramtype = params.activated_light and "light" or nil
    activated.disabled_machine_name = nodename
    activated.technic_run = function(coord)
        local meta = minetest.get_meta(coord)
        local eu_input = meta:get_int("LV_EU_input")

        if eu_input < params.demand then
            technic.swap_node(coord, nodename)
            return
        end

        params.on_technic_run_enabled(coord, meta, eu_input)
    end

    for k, v in pairs(active_override) do
        activated[k] = v
    end

    return unactivated, activated
end

function utils.map_child_entity(coord, name, func)
    local objects = minetest.get_objects_inside_radius(coord, 1)
    for _, obj in ipairs(objects) do
        if obj:get_luaentity() and obj:get_luaentity().name == name then
            func(obj)
            return
        end
    end
end

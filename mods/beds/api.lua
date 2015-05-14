function beds.register_bed(name, def)
	local multinode_def = {{name = name .. "_bottom", offset = {x = 0, y = 0, z = 0}},
	                       {name = name .. "_top", offset = {x = 0, y = 0, z = 1}}}
	local on_rotate = multinode.on_rotate(multinode_def)
	minetest.register_node(name .. "_bottom", {
		description = def.description,
		inventory_image = def.inventory_image,
		wield_image = def.wield_image,
		drawtype = "nodebox",
		tiles = def.tiles.bottom,
		paramtype = "light",
		paramtype2 = "facedir",
		stack_max = 1,
		groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, bed = 1},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = def.nodebox.bottom,
		},
		selection_box = {
			type = "fixed",
			fixed = def.selectionbox,
				
		},
		on_construct = multinode.on_construct(multinode_def),
		after_place_node = multinode.after_place_node,
		on_destruct = multinode.on_destruct(multinode_def),
		on_rightclick = function(pos, node, clicker)
			beds.on_rightclick(pos, clicker)
		end,
		on_rotate = function(pos, node, user, mode, new_param2)
			if mode ~= screwdriver.ROTATE_FACE then
				return false
			end
			return on_rotate(pos, node, user, mode, new_param2)
		end,
	})

	minetest.register_node(name .. "_top", {
		drawtype = "nodebox",
		tiles = def.tiles.top,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, bed = 2},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = def.nodebox.top,
		},
		selection_box = {
			type = "fixed",
			fixed = {0, 0, 0, 0, 0, 0},
		},
		on_construct = multinode.on_construct(multinode_def),
		on_destruct = multinode.on_destruct(multinode_def),
		on_rotate = function(pos, node, user, mode, new_param2)
			if mode ~= screwdriver.ROTATE_FACE then
				return false
			end
			return on_rotate(pos, node, user, mode, new_param2)
		end,
	})

	minetest.register_alias(name, name .. "_bottom")

	-- register recipe
	minetest.register_craft({
		output = name,
		recipe = def.recipe
	})
end

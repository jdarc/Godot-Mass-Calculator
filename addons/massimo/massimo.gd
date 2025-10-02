@tool
extends EditorContextMenuPlugin

const ICON: Texture2D = preload("uid://c5o4psvy6ygi4")

func _popup_menu(paths: PackedStringArray) -> void:
	var popup_menu := PopupMenu.new()
	for item: String in MassCalculator.MATERIAL_DENSITY_TABLE.keys():
		popup_menu.add_item(item)
	popup_menu.id_pressed.connect(_apply_material)
	add_context_submenu_item("Calculate Mass", popup_menu, ICON)

func _apply_material(id: int) -> void:
	var key: String = MassCalculator.MATERIAL_DENSITY_TABLE.keys()[id]
	var nodes := EditorInterface.get_selection().get_selected_nodes()
	for node: Node in nodes:
		if node is RigidBody3D:
			node.mass = MassCalculator.calculate_mass(node, key)
		else:
			for body: RigidBody3D in node.find_children(&"*", &"RigidBody3D"):
				body.mass = MassCalculator.calculate_mass(body, key)

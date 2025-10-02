@tool
extends EditorPlugin

var massimo_plugin: EditorContextMenuPlugin

func _enter_tree() -> void:
	massimo_plugin = preload("res://addons/massimo/massimo.gd").new()
	add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_SCENE_TREE, massimo_plugin)

func _exit_tree() -> void:
	remove_context_menu_plugin(massimo_plugin)

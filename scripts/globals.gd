extends Node


var pixel_canvas: PixelCanvas

var paused: bool = false

var pause_menu_scene: PackedScene
var pause_menu: PauseMenuUI


func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS
    pause_menu_scene = preload("res://scenes/ui/pause_menu_ui.tscn")
    pause_menu = pause_menu_scene.instantiate()
    
    # get_tree().root.add_child(pause_menu)
    pause_menu.hide()


func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_cancel"):
        if not paused:
            pause()
        else:
            resume()
        

func pause() -> void:
    paused = true
    get_tree().paused = true
    get_tree().root.add_child(pause_menu)
    pause_menu.show()

func resume() -> void:
    paused = false
    get_tree().paused = false
    get_tree().root.remove_child(pause_menu)
    pause_menu.hide()

class_name PaletteButton
extends Button


var color_index: int = -1

@export var sb: StyleBoxFlat

var my_sb: StyleBoxFlat
var l: float

func set_is_primary(is_primary: bool) -> void:
    # Set the button as primary or secondary
    if is_primary:
        my_sb.border_color = Color(1, 0, 0, 1) # gray
        
        
    else:
        my_sb.border_color = Color(0, 0, 0, 1) # gray

       
func set_button_text(new_text: String) -> void:
    # Set the button text
    text = new_text

func set_button_color(new_color_index: int, color: Color) -> void:
    color_index = new_color_index
    # Set the button color
    print("color is: ", color)


    my_sb = sb.duplicate() as StyleBoxFlat
    
    my_sb.bg_color = color
    my_sb.set_border_width_all(2)
    my_sb.border_color = Color.BLACK

    add_theme_stylebox_override("normal", my_sb)
    add_theme_stylebox_override("focus", my_sb)
    add_theme_stylebox_override("pressed", my_sb)

    
    l = color.get_luminance()

    if l < 0.5:
        add_theme_color_override("font_color", Color(1, 1, 1, 1)) # white
        add_theme_color_override("font_pressed_color", Color(1, 1, 1, 1)) # white
        add_theme_color_override("font_focus_color", Color(1, 1, 1, 1)) # white
        add_theme_color_override("font_hover_color", Color(1, 1, 1, 1)) # white
    else:
        add_theme_color_override("font_color", Color(0, 0, 0, 1)) # black
        add_theme_color_override("font_pressed_color", Color(0, 0, 0, 1)) # black
        add_theme_color_override("font_focus_color", Color(0, 0, 0, 1)) # black
        add_theme_color_override("font_hover_color", Color(0, 0, 0, 1)) # black
extends Control

# get the size of the viewport
@onready var viewportSize = get_size()

# get the Camera2D child of the viewport control node
@onready var cam = get_node("Camera")

# camera dragging settings
var scrollSpeed = 20 # for the speed of the camera dragging
var originPos
var isDragging = false
var dragFactor = 0.45 # Adjust the drag factor for smoother movement

func _input(event):
	if event.is_action_pressed("resetCamera"):
		cam.position = Vector2(viewportSize.x / 2, viewportSize.y / 2)
		print("_DEBUG: Update, camera position reset")		
	elif event.is_action_pressed("dragCamera"):
		originPos = get_local_mouse_position()
		isDragging = true
		
	elif event.is_action_released("dragCamera"):
		isDragging = false

	
func _physics_process(delta):
	if isDragging:
		var targetPos = cam.position.lerp(get_local_mouse_position(), scrollSpeed * delta * dragFactor)
		cam.position = targetPos

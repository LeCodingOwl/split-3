class_name	Trail3D extends MeshInstance3D

var _points =[]
var _widths = []
var _lifePoints = []

@export var _trailEnabled : bool = true

@export var _fromWidth : float = .5
@export var _toWidth : float = 0.0
@export_range (.5,1.5) var _scaleAcceleration: float = 1.0

@export var _motionDelta: float = .1
@export var _lifespan: float =1 

@export var _startColor: Color = Color (1,1,1,1)
@export var _endColor: Color = Color (1,1,1,1)





# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

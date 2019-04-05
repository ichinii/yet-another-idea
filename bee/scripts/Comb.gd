extends Node2D

enum CombType { BEE, HONEY }
var comb_type = CombType.BEE # CombType
var evolution_states: int

signal comb_evolution_finished

func start_evolution() -> void:
	$EvolutionTimer.start()
	
func stop_evolution() -> void:
	$EvolutionTimer.stop()

func set_evolution_time(new_val: float) -> void:
    $EvolutionTimer.wait_time = new_val

func set_evolution_state(new_val: int) -> void:
	assert new_val < evolution_states
	$AnimatedSprite.frame = new_val
	if $AnimatedSprite.frame == evolution_states -1:
		emit_signal("comb_evolution_finished")
		stop_evolution()

func increment_evolution_state() -> void:
	set_evolution_state($AnimatedSprite.frame + 1)

func get_evolution_state() -> int:
    return $AnimatedSprite.frame

func _ready() -> void:
	match comb_type:
		CombType.BEE:
			$AnimatedSprite.animation = "bee"
		CombType.HONEY:
			$AnimatedSprite.animation = "honey"
	
	evolution_states = $AnimatedSprite.frames.get_frame_count($AnimatedSprite.animation)
	start_evolution()

func _on_EvolutionTimer_timeout() -> void:
	if $AnimatedSprite.frame < evolution_states:
		increment_evolution_state()

class_name HUD
extends CanvasLayer

@onready var health_bar := %HealthBar as TextureProgressBar
@onready var money_label := %MoneyLabel as Label
@onready var wave_label := %WaveLabel as Label
@onready var next_wave_panel := %NextWave as Panel
@onready var countdown_label := %Countdown as Label
@onready var next_wave_timer := %Timer as Timer

func initialize(max_health: int) -> void:
	health_bar.max_value = max_health
	health_bar.value = health_bar.max_value


func _on_objective_health_changed(health: int) -> void:
	health_bar.value = health


func _on_spawner_countdown_started(seconds: float) -> void:
	next_wave_panel.show()
	next_wave_timer.start(seconds)


func _on_spawner_wave_started(current_wave: int) -> void:
	wave_label.text = "Wave: %d" % current_wave


func _on_money_changed(money: int) -> void:
	money_label.text = str(money)


func _process(_delta: float) -> void:
	if not next_wave_timer.is_stopped():
		countdown_label.text = str(ceil(next_wave_timer.time_left))


func _on_timer_timeout():
	next_wave_panel.hide()

# Off-screen enemy indicator pseudocode #
#
# Make a collection for storing references to enemies in scene tree
# Use signals to add reference to each new enemy spawned
# Use signals to remove reference to each enemy which just exited scene tree
# Update camera bounds in world space every frame? I know there's one camera so that would be easy
# If an enemy is out of camera bounds, dynamically draw HUD element pointing to enemy based
#   on their location relative to camera (hugging the screen edges, so to speak)
#   and showing enemy
# If an enemy enters camera bounds, stop drawing the HUD element

# UI Feature Reminder #
#
# Add HUD elements for countdown to next wave, total enemies this wave, and total enemies remaining
# For total enemies remaining, subtract from total for wave each time enemy death signal is received; see indicator pseudocode
# For total enemies, interact with enemy spawner?
# See how the game staggers waves and use that information for the countdown

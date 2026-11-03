extends Node

## flag dictionary containing enum of upgrade id pointing to t/f
var flags: Dictionary[Upgrade.ID, bool] = {}

func _ready():
	for id in Upgrade.ID.values():
		flags[id] = false

func buy_upgrade(upgrade: Upgrade):
	flags[upgrade.id] = true
	GameState.money -= upgrade.cost

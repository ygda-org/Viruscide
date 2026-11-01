extends Resource
class_name Upgrade

## enum of identifiers for each unique upgrade
enum ID {
	TEST_ID
}

## the specific identifier this resource has
@export var id: ID
@export_category("Shop Details")
@export var display_name: String
@export var description: String
@export var cost: int

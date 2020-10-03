extends GameEnterArea

func get_reward():
	ResourceManager.hunger+=10
	ResourceManager.thirst-=10

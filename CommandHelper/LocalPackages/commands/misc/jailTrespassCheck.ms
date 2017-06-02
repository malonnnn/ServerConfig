bind(gamemode_change, null, array(newmode: SURVIVAL), @Event,

	@world = pworld(@Event[player]); # Players current world
	
	if (@world == 'overvoid'){
	
		if (!has_permission('is.criminal')) {
		
			runas('~console', '/arrest '.@Event[player].' Jumping into jail'); # Jail the player
		
		}	
	
	}	

)

register_command(bloodregen, 

    array(
    
        description: 'Regeneration',
        
        permission: 'ch.alias.bloodregen',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {
		
			@player = player()
    
			assign(@cooldown, 60)
			
			assign(@lastUsedBloodRegen, import(@player."lastUsedBloodRegen"))
			if(@lastUsedBloodRegen + @cooldown > time() / 1000,
				assign(@timeleft, subtract(add(@lastUsedBloodRegen, @cooldown), divide(time(),1000)))
				tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use blood regen again!'))
				die()
			)
			export(@player."lastUsedBloodRegen", time() / 1000)
			
			runas(~console,'/effect '.@player.' minecraft:regeneration 9999 1 true')
			runas(~console,'/effect '.@player.' minecraft:saturation 9999 1 true')

			
			tmsg(@player,color(red)."Don't move, or your regen will stop!")
			@filter = associative_array('player': @player)
			try(
				bind(player_move, null, @filter, @event, @player,
					runas(~console,'/effect '.@player.' minecraft:regeneration 0')
					runas(~console,'/effect '.@player.' minecraft:saturation 0')
					unbind()
				)
			,)
                
        }
    )
)
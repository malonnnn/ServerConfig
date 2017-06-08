register_command(mrshiftytp, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.mrshiftytp',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
			
			@player = player()
			@multiplier = 0.2
			@projectile = shoot_projectile(@player,'ENDER_PEARL')
			@velocity = entity_velocity(@projectile)
			set_entity_velocity(@projectile, array(@velocity['x'] * @multiplier, @velocity['y'] * @multiplier, @velocity['z'] * @multiplier))
                
        }
    )
)

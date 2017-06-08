register_command(empower, 

    array(
    
        description: 'Gives player strength 10 for 5 minutes',
        
        permission: 'ch.alias.empower',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {
        
			@plr = $plr
			sudo(/effect @plr 5 300 10 true)
			tmsg(player(), "You have empowered ".@plr."!")
			tmsg(@plr, "You have been empowered by ". player() ."!")
                
        }
    )
)
register_command(rasengan, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.rasengan',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
			
			@plr = player()
			runas(~console,"/effect " . @plr . " 5 10 10 true")
			tmsg(@plr,"You have powerful punches for 10 seconds!")
                
        }
    )
)

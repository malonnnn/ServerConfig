register_command(apokolips, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.apokolips',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
			
			sudo("/mv tp survival_nether")
                
        }
    )
)
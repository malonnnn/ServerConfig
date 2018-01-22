register_command(waitformyth, 

    array(
    
        description: 'Say Wait For Myth',
        
        usage: '/waitformyth',
        
        permission: 'ch.alias.waitformyth',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',	
    
        executor: closure() {
                
                broadcast(color(RED).color(BOLD).' Wait For Myth PLEASE ')
        
        }
    )
)

register_command(askmyth, 

    array(
    
        description: 'Say Ask Myth',
        
        usage: '/askmyth',
        
        permission: 'ch.alias.askmyth',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',	
    
        executor: closure() {
                
                broadcast(color(RED).' Ask Myth ')
        
        }
    )
)

register_command(judgeclassannounce, 

    array(
    
        description: 'Broadcast judge class announcement',
        
        usage: '/judgeclassannounce',
        
        permission: 'ch.alias.judgeclassannounce',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',	
    
        executor: closure() {
                
                broadcast(color(AQUA).' Judge Class is about to commence! To get into Judge School, do /home RqndomPqrson:school ')
        
        }
    )
)

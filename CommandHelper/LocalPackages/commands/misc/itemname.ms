register_command(itemname, 

    array(
    
        description: 'Item Name',
        
        usage: '/itemname',
        
        permission: 'ch.alias.itemname',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',	
    
        executor: closure() {
                
                msg(color(RED).color(BOLD).' For Names Of Items For /create Go To ')
                msg(color(WHITE).' http://minecraft-ids.grahamedgecombe.com/ ')
                msg(color(RED).color(BOLD).' You Can Also Do F3 + H And Hover Over The Item!')
        
        }
    )
)

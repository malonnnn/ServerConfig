register_command(speedforcebuffs, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.speedforcebuffs',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
            
            runas(~console,"/effect ".player()." 5 9999 254 true")
            msg(color(RED).'You can now one-punch anyone who you bring to the speedforce using /speedforceteleport <player>')                
        }
    )
)

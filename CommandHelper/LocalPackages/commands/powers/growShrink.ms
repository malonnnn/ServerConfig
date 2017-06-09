register_command(grow, 

    array(
    
        description: 'Turn into a giant',
        
        permission: 'ch.alias.grow',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {
        
            sudo(/disguise giant) 
                
        }
    )
)

register_command(shrink, 

    array(
    
        description: 'Shrink',
        
        permission: 'ch.alias.shrink',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {
        
            include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
    
            @player = player()
            @class = pgroup()[0]

            include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms')
            
            @sig = @hero['sig']
            @val = @hero['val']
            _changeSkin(@player,@sig,@val)
                
        }
    )
)
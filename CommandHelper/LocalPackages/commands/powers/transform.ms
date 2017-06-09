register_command(transform, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.transform',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
            
            runas(~console,'/disguiseplayer '.player().' minecart')
                
        }
    )
)

register_command(untransform, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.untransform',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
            
            include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
    
            @plr = player()
            @class = pgroup()[0]
            
            try(
                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms')
                _changeSkin(@plr,@hero['sig'],@hero['val'])
            ,
                sudo('/undisguise')
            )
                
        }
    )
)
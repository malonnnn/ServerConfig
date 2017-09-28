register_command('anarchystart', 

    array(
    
        description: 'Starts Anarchy Mode',
        usage: '/anarchystart <plr>',
        permission: 'commands.anarchystart',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 0) {
                return(false)	
            }
            
            @plr = player()

            sudo('/pex user '.@plr.' add multiverse.access.anarchy')
            sudo('/warp anarchyspawn '.@plr)
            sudo('/pex user '.@plr.' remove multiverse.access.anarchy')
        }
    )
)
register_command('anarchyleave', 

    array(
    
        description: 'Leaves Anarchy Mode',
        usage: '/anarchyleave <plr>',
        permission: 'commands.anarchyleave',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                return(false)	
            }
            
            @plr = @args[0]

            sudo('/warp centralhub '.@plr)
        }
    )
)

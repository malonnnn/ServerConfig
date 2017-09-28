register_command('anarchyspec', 

    array(
    
        description: 'Sets a player to Spectator Mode in Anarchy World',
        usage: '/anarchyspec <plr>',
        permission: 'commands.anarchyspec',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 0) {
                return(false)				
            }
            
            @plr = player()

            sudo('/pex user '.@plr.' group set anarchyspectator')
            set_pmode(@plr,'SPECTATOR')

            tmsg(@plr,color(RED).'Welcome to Anarchy Spectator Mode! Use '.color(GREEN).'/anarchyplay'.color(RED).' to go back to normal play')

        }
    )
)
register_command('anarchyplay', 

    array(
    
        description: 'Sets a player to Survival Mode in Anarchy World',
        usage: '/anarchyplay',
        permission: 'commands.anarchyplay',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 0) {
                return(false)
            }
            
            @plr = player()

            sudo('/pex user '.@plr.' group set anarchy')
            set_pmode(@plr,'SURVIVAL')
            sudo('/warp anarchyspawn '.@plr)

            tmsg(@plr,color(RED).'You have returned to normal Anarchy Mode.')

        }
    )
)

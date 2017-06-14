register_command('goanarchy', 

    array(
    
        description: 'Sets a player to Spectator Mode in Anarchy World',
        usage: '/anarchyspec <plr>',
        permission: 'commands.anarchyspec',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /goanarchy <plr>');
                die(); # No need to go further					
            
            }
            
            @plr = @args[0]

            sudo('/pex user '.@plr.' add multiverse.access.anarchy')
            sudo('/warp anarchyspawn '.@plr)
            sudo('/pex user '.@plr.' remove multiverse.access.anarchy')

        }
    )
)

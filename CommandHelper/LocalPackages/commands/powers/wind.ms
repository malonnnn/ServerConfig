register_command(wind, 
    array(
        description: 'Power',
        permission: 'ch.alias.wind',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /wind <player>');
                die(); # No need to go further					
            
            }
            
            @player = player()
            @plr = @args[0]

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedWind',10000,@player)

            sudo("/push ".@plr)
            tmsg(@plr,"You have been pushed by ".@player."!")
            tmsg(player(),"You have pushed ".@plr."!")
                
        }
    )
)

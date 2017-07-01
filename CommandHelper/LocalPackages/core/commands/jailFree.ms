register_command('jailfree', 

    array(
        description: 'Displays procedure information for server staff',
        usage: '/jailfree <playername>',
        permission: 'command.jailfree',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'/jailfree <playername>');
                    die(); # No need to go further					
                
                }	
                
                @plr = @args[0]
                @ploc = ploc(@plr)
                @ploc['x'] =  -100.5
                @ploc['y'] = 96.5
                @ploc['z'] = 50.5
                @players = players_in_radius(@ploc,1)
                @numOfPlayers = array_size(@players)
                if(@numOfPlayers > 1){
                    tmsg(@plr,color(RED).'Error: Too many people on red square!')
                    die()
                }

                if(@numOfPlayers == 0){
                    tmsg(@plr,color(RED).'Error: No one on the red square!')
                    die()
                }

               pkill(@players[0]) 
        }
    )
)

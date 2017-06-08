register_command(carryplayer, 

    array(
    
        description: 'Pickup a player and carry them',
        
        permission: 'ch.alias.carryplayer',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        tabcompleter: closure(@alias, @sender, @args) {
            try{
                if(array_size(@args) == 0) {
                    return(all_players());
                }
                @search = @args[array_size(@args) - 1];
                    return(array_filter(all_players(), closure(@index, @player) {
                    return(equals_ic(@search, substr(@player, 0, length(@search))));
                }));
            } catch (RangeException @ErrorInfo) {
                # Ignore
            }
        },
    
        executor: closure(@alias, @sender, @args) {
        
			if (array_size(@args) != 1) {
			
				msg(''.color(RED).color(BOLD).'Improper Usage!');
				msg(''.color(RED).'Usage: /carryplayer <player>');
				die(); # No need to go further					
			
			}
			
			@plr = player()
			@vic = @args[0]

			@ploc = ploc()
			@vicLoc = ploc(@vic)
			
			@players = players_in_radius(@ploc,2)
			
			if(@ploc['world'] != @vicLoc['world']){
				die("Sorry, you have to be in the same world as that person!")
			}

			@x1 = @ploc['x']
			@y1 = @ploc['y']
			@z1 = @ploc['z']

			@x2 = @vicLoc['x']
			@y2 = @vicLoc['y']
			@z2 = @vicLoc['z']

			@x3 = pow(@x1 - @x2, 2)
			@y3 = pow(@y1 - @y2, 2)
			@z3 = pow(@z1 - @z2, 2)

			@final = @x3 + @y3 + @z3

			@distance = sqrt(@final)
		   
			if(@distance > 2){
				tmsg(@plr, "Make sure you are close enough to grab that person!")
				die()
			}

			set_entity_rider(puuid(@plr,true),puuid(@vic,true))
			tmsg(@vic, @plr." grabbed you")
			tmsg(@plr, "You grabbed ".@vic."!")
                
        }
    )
)

register_command(dismountplayer, 

    array(
    
        description: 'Dismount player',
        
        permission: 'ch.alias.dismountplayer',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {
		
			@rider = get_entity_rider(puuid(player()))

			if(@rider != null){
				set_entity_rider(null,@rider)
			}
                
        }
    )
)

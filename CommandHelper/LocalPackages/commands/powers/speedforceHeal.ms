register_command(speedforceheal, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.speedforceheal',
        
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
				msg(''.color(RED).'Usage: /speedforceheal <player>');
				die(); # No need to go further					
			
			}
			
			@plr = player()
			@vic = @args[0]

			@ploc = ploc()
			@vicLoc = ploc(@vic)


			if(@ploc['world'] != @vicLoc['world']){
				die("Sorry, that person has to be in the speedforce with you!")
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
				tmsg(@plr, "Make sure you are close enough to grab your victim!")
				die()
			}

			runas(~console,"/heal ".@vic)
			tmsg(@vic, "You have been speedforce healed by ".@plr)
			
        }
    )
)

register_command(psypush, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.psypush',
        
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
				msg(''.color(RED).'Usage: /psypush <player>');
				die(); # No need to go further					
			
			}
			
			@player = player()
			assign(@cooldown, 30)
			
			assign(@lastUsedPsyPush, import(@player."lastUsedPsyPush"))
			if(@lastUsedPsyPush + @cooldown > time() / 1000,
				die(color(red)."You must cool down before you can use psy push again!")
			)
			export(@player."lastUsedPsyPush", time() / 1000)

			@ploc = ploc()
			@vic = @args[0]

			@vicLoc = ploc(@vic)

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

			@final = sqrt(@final)
			
			@maxDist = 30
			@magnitude = (1 - @final / @maxDist) * 5 

			@yaw = @ploc['yaw'] + 90;
			@pitch = neg(@ploc['pitch']);
			@vector = associative_array();
			@vector['x'] = @magnitude * (cos(to_radians(@yaw)) * cos(to_radians(@pitch)));
			@vector['y'] = @magnitude * sin(to_radians(@pitch));
			@vector['z'] = @magnitude * (sin(to_radians(@yaw)) * cos(to_radians(@pitch)));
			set_pvelocity(@vic,@vector) 
			
        }
    )
)

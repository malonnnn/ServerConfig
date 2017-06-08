register_command(push, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.push',
        
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
        
			if (array_size(@args) != 4) {
			
				msg(''.color(RED).color(BOLD).'Improper Usage!');
				msg(''.color(RED).'Usage: /push <player> <x> <y> <z>');
				die(); # No need to go further					
			
			}
			
			@plr = @args[0]
			@x = @args[1]
			@y = @args[2]
			@z = @args[3]
			@uuid = pinfo(@plr,20)
			set_entity_velocity(@uuid, array(@x,@y,@z))
			
        }
    )
)
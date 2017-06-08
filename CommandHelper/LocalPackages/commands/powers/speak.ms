register_command(speak, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.speak',
        
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
        
			if (array_size(@args) < 2) {
			
				msg(''.color(RED).color(BOLD).'Improper Usage!');
				msg(''.color(RED).'Usage: /speak <player> <msg>');
				die(); # No need to go further					
			
			}
			
			@msg = ''
			@plr = @args[0]
			@plrSpeaking = player()
			
			for (@i=1, @i < array_size(@args), @i++){
			
				@msg = @msg.' '.@args[@i]
			
			}
			
			@msg = trim(@msg)
			
			sudo('/sudo '.@plr.' c:.'.@msg)
			
			@players = all_players()
			
			foreach (@player in @players){
			
				if (has_permission(@player, 'ch.alias.onduty')){
				
					tmsg(@player, color(GRAY).color(ITALIC).'*Player Speaking*: '.@plrSpeaking)
				
				}
			
			}
			
        }
    )
)
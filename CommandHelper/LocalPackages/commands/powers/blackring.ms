register_command(blackring, 

    array(
    
        description: 'Hero Power',
        
        permission: 'ch.alias.blackring',
        
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
				msg(''.color(RED).'Usage: /blackring <player>');
				die(); # No need to go further					
			
			}
			
			@vic = @args[0]

			if(ponline(@vic)){
				@class = pgroup(@vic)[0]
				@vicWorld = pworld(@vic)
				
				if(
					@vicWorld == "survival" ||
					@vicWorld == "survival_nether" ||
					@vicWorld == "survival_the_end" ||
					@vicWorld == "greenfield" ||
					@vicWorld == "destructiblecity" ||
					@vicWorld == "titanstower" ||
					@vicWorld == "gotham" ||
					@vicWorld == "metropolis"
				){}else{
					die()
				}

				include('includes/transform.ms')

				if(@class == "superman"){
					_transform(@vic,"blacklanternsuperman")
				}else if(@class == "martianmanhunter"){
					_transform(@vic,"blacklanternmartianmanhunter")
				}
			}
                
        }
    )
)
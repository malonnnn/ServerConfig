register_command(invishandsattack, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.invishandsattack',
        
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
				msg(''.color(RED).'Usage: /invishandsattack <player>');
				die(); # No need to go further					
			
			}
			
			@vic = @args[0]
			@vic = player(@vic)
			@plr = player()
			@ploc = ploc(@plr)

			if(ponline(@vic)){
				@plrs = players_in_radius(@ploc,10)
				foreach(@player in @plrs){
					if(@vic == @player){
						damage_entity(puuid(@vic),40,puuid(@plr))
					}else{
						tmsg(@plr,color(red).'You are not close enough to that player!')
					}
				}   
			}
			
        }
    )
)

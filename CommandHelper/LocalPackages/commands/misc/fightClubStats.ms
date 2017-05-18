register_command(fightclubstats, 

	array(
	
		description: 'Check the Fight Club stats of another Player or Yourself',
		
		usage: '/fightclubstats [player]',
		
		permission: 'ch.alias.fightclubstats',
		
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
		
				if (array_size(@args) > 1) {
				
					msg(''.color(RED).color(BOLD).'Improper Usage!');
					msg(''.color(RED).'Usage: /fightclubstats  <player>');
					die(); # No need to go further					
				
				}
				
				if (array_size(@args) == 1) {
				
					@plr = player(@args[0])
					
				} else {
				
					@plr = player()
					
				}

				@wins = get_value(@plr.'fightClubWins')
				@losses = get_value(@plr.'fightClubLosses')

				if(@wins == null || @wins == ''){
					@wins = 0
				}

				if(@losses == null || @losses == ''){
					@losses = 0
				}
				
				if (array_size(@args) == 1) {
				
					tmsg(player(),@plr.color(red).' has '.@wins.' wins and '.@losses.' losses')
					
				} else {
				
					tmsg(@plr,color(red).'You have '.@wins.' wins and '.@losses.' losses')
					
				}

		}
	)
)

register_command(killfighter, 

	array(
	
		description: 'Kills a fighter in Fight Club',
		
		usage: '/killfighter <player>',
		
		permission: 'killfighter',
		
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
		
				if (array_size(@args) != 2) {
				
					msg(''.color(RED).color(BOLD).'Improper Usage!');
					msg(''.color(RED).'Usage: /killfighter <player>');
					die(); # No need to go further					
				
				}
				
				try {
					@plr = player(@args[0])
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}				
				
				@isFighting = import(@plr.'fcvs') 
				if(@isFighting != null && @isFighting != ''){
					pkill(@plr)
					broadcast(@plr.color(red).' lost Fight Club trying to escape!')
				}
		
		}
	)
)

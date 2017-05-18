register_command(officekill, 

	array(
	
		description: 'Arrests a player and Jails them',
		
		usage: '/officekill <player>',
		
		permission: 'ch.alias.officekill',
		
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
					msg(''.color(RED).'Usage: /officekill <player>');
					die(); # No need to go further					
				
				}
				
				try {
					@vic = player(@args[0])
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}
				
				if(pworld(@vic) == 'office'){
					pkill(@vic)
				}else{
					tmsg(player(),color(red).'Sorry, that player is not in the office.')
				}		
		
		}
	)
)

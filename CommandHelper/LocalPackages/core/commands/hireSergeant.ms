register_command(hiresergeant, 

	array(
	
		description: 'Hire\'s a Player as a Server Police Sergeant',
		
		usage: '/hiresergeant <player>',
		
		permission: 'hiresergeant',
		
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
					msg(''.color(RED).'Usage: /hiresergeant <player>');
					die(); # No need to go further					
				
				}
				
				try {
				
					@player = player(@args[0])
					
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}		
				
				sudo("/pex user ".@player." add is.sergeant")
				sudo("/pex user ".@player." add ch.alias.onduty")
				tmsg(player(),color(red)."You have hired ".@player. " as a Sergeant for the Police Force!")
				tmsg(@player,color(red)."You have been hired as a Sergeant for the Police Force!")
		
		}
	)
)

register_command(firesergeant, 

	array(
	
		description: 'Fire\'s a Player as a Server Police Sergeant',
		
		usage: '/firesergeant <player>',
		
		permission: 'firesergeant',
		
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
					msg(''.color(RED).'Usage: /firesergeant <player>');
					die(); # No need to go further					
				
				}
				
				try {
				
					@player = player(@args[0])
					
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}				
				
				if(has_permission(@player,"is.officer")){
					sudo("/pex user ".@player." remove is.sergeant")
					sudo("/pex user ".@player." remove ch.alias.onduty")
					sudo("/pex user ".@player." group set mortal")
					tmsg(player(),color(red)."You have fired ". @player ." from the Police Force.")
					tmsg(@player,color(red)."You have been fired from the Police Force :(")
				}
		
		}
	)
)

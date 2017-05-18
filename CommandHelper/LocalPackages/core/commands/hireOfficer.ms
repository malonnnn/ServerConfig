register_command(hireofficer, 

	array(
	
		description: 'Hire\'s a Player as a Server Police Officer',
		
		usage: '/hireofficer <player>',
		
		permission: 'ch.alias.hireofficer',
		
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
					msg(''.color(RED).'Usage: /hireofficer <player>');
					die(); # No need to go further					
				
				}
				
				try {
				
					@player = player(@args[0])
					
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}		
				
				sudo("/pex user ".@player." add ch.alias.onduty")
				sudo("/pex user ".@player." add is.officer")
				tmsg(player(),color(red)."You have hired ".@player." as on Officer for the Police Force!")
				tmsg(@player,color(red)."You have been hired as an Officer for the Police Force!")	
		
		}
	)
)

register_command(fireofficer, 

	array(
	
		description: 'Fire\'s a Player as a Server Police Officer',
		
		usage: '/fireofficer <player>',
		
		permission: 'ch.alias.fireofficer',
		
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
					msg(''.color(RED).'Usage: /fireofficer <player>');
					die(); # No need to go further					
				
				}
				
				try {
				
					@player = player(@args[0])
					
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}				
				
				if(has_permission(@player,"is.officer")){
					sudo("/pex user ".@player." remove ch.alias.onduty")
					sudo("/pex user ".@player." remove is.officer")
					sudo("/pex user ".@player." group set mortal")
					sudo("/minecraft:clear ".@player)
					tmsg(player(),color(red)."You have fired ". @player ." from the Police Force.")
					tmsg(@player,color(red)."You have been fired from the Police Force :(")
				}
		
		}
	)
)

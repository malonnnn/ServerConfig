register_command(marry, 

	array(
	
		description: 'Marry another Player',
		
		usage: '/marry <player>',
		
		permission: 'ch.alias.marry',
		
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
					msg(''.color(RED).'Usage: /marry <player>');
					die(); # No need to go further					
				
				}
				
				try {
				
					@vic = player(@args[0])
					@player = player()

					if(has_permission(@player,'is.married')){
						@spouse = get_value(@player.'spouse')
						if(@spouse != null){
							tmsg(@player,color(red).'Sorry, you are already married to '.@spouse.'!')
							die()
						}
					}

					if(has_permission(@vic,'is.married')){
						@spouse = get_value(@vic.'spouse')
						if(@spouse != null){
							tmsg(@player,color(red).'Sorry, they are already married to '.@spouse.'!')
							die()
						}
					}

					@vic = player(@vic)

					if(@player == @vic){
						tmsg(@player,color(red).'You cannot marry yourself!')
						die()
					}

					store_value(@player.'spouse',@vic)
					if(get_value(@vic.'spouse') != null && get_value(@vic.'spouse') == @player && @player != @vic){
						broadcast("§c❤❤❤§a ".@player." §6and§a ".@vic." §6just got married! §c❤❤❤")
						runas(~console,'/pex user '.@player.' add is.married')
						runas(~console,'/pex user '.@vic.' add is.married')
					}else{
						tmsg(@player,color(red).'Once your crush does '.color(green).'/marry '.@player.color(red).' then you two will be officially married!')

					}
					
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}					
				
		
		}
	)
)

register_command(divorce, 

	array(
	
		description: 'Grant two Players a Divorce',
		
		usage: '/divorce <player1> <player2>',
		
		permission: 'ch.alias.divorce',
		
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
					msg(''.color(RED).'Usage: /divorce <player1> <player2>');
					die(); # No need to go further					
				
				}
				
				try {
				
					@plr1 = player(@args[0])
					@plr2 = player(@args[1])					
					
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}		

				runas(~console,'/pex user '.@plr1.' remove is.married')
				runas(~console,'/pex user '.@plr2.' remove is.married')

				store_value(@plr1.'spouse','')
				store_value(@plr2.'spouse','')
				
				tmsg(@plr1,color(red).'You are now officially single!')
				tmsg(@plr2,color(red).'You are now officially single!')
		
		}
	)
)

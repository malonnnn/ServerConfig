register_command(arrest, 

	array(
	
		description: 'Arrests a player and Jails them',
		
		usage: '/arrest <player> <reason>',
		
		permission: 'arrest',
		
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
					msg(''.color(RED).'Usage: /arrest <player> <reason>');
					die(); # No need to go further					
				
				}
				
				try {
					@plr = player(@args[0])
					@cop = player()
					@vicUUID = puuid(@plr)
					@ip = pinfo(@plr)[3]
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}				
				
				@reason = ''
				@argsLength = array_size(@args)
				
				for (@i = 1, @i < @argsLength, @i++){
				
					@reason = @reason.@args[@i]
				
				}				
				
				@date = simple_date('hh:mm aaa z',time(),'CST')

				sudo('/sudo '.@plr.' c:/ch leave local')
				sudo('/sudo '.@plr.' c:/ch join global')
				include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
				_mortal(@plr)
				broadcast(@plr.color(red).' HAS BEEN ARRESTED BY '.color(white).@cop.color(red).' FOR '.color(yellow).@reason)				

				@profile = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/policedatabase.sqlite')
				
				@date = simple_date('yyyy-MM-dd HH:mm:ss', time())
				@result = query(@profile,'INSERT INTO `criminals` '.
										 'VALUES(?,?,?,?,?,?,?,?)',
										 @plr,@vicUUID,@reason,'ARREST',@ip,@cop,puuid(@cop),simple_date('yyyy-MM-dd HH:mm:ss', time())
				)

				set_timeout(3000,closure(
					sudo("/pex user ".@plr." group set criminal")
					sudo("/tptoggle ".@plr." off")
					sudo("/warp quarantine ".@plr)
				))			
		
		}
	)
)

register_command(release, 

	array(
	
		description: 'Release a player from Jail',
		
		usage: '/release <player>',
		
		permission: 'release',
		
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
					msg(''.color(RED).'Usage: /release <player>');
					die(); # No need to go further					
				
				}
				
				try {
					@plr = player(@args[0])
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}
				
				sudo("/pex user ".@plr." group set mortal")
				sudo("/warp city ".@plr)
				sudo("/tptoggle ".@plr." on")			
		
		}
	)
)

register_command(warn, 

	array(
	
		description: 'Warns a player for Behavior and records Infraction',
		
		usage: '/warn <player> <reason>',
		
		permission: 'warn',
		
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
					msg(''.color(RED).'Usage: /warn <player> <reason>');
					die(); # No need to go further					
				
				}
				
				try {
					@plr = player(@args[0])
					@cop = player()
					@uuid = puuid(@plr)
					@ip = pinfo(@plr)[3]
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}				
				
				@reason = ''
				@argsLength = array_size(@args)
				
				for (@i = 1, @i < @argsLength, @i++){
				
					@reason = @reason.@args[@i]
				
				}			
				
				broadcast(color(bold).@plr.color(dark_red).color(bold).' HAS BEEN WARNED BY '.color(white).@cop.color(dark_red).color(bold).' ON THE GROUNDS OF '.color(yellow).@reason.color(red).color(bold).'. Please read '.color(dark_red).'/warp rules'.color(red).' and familiarize yourself with the server rules or you may end up jailed!')

				@profile = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/policedatabase.sqlite')
				query(@profile,'INSERT INTO `criminals` '.
							   'VALUES(?,?,?,?,?,?,?,?)',
							   @plr,@uuid,@reason,'WARN',@ip,@cop,puuid(@cop),simple_date('yyyy-MM-dd HH:mm:ss', time())
				)			
		
		}
	)
)

register_command(checkfingerprints, 

	array(
	
		description: 'Checks for Information on a Player',
		
		usage: '/checkfingerprints <player>',
		
		permission: 'checkfingerprints',
		
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
					msg(''.color(RED).'Usage: /checkfingerprints <player>');
					die(); # No need to go further					
				
				}

				try {
					@plr = player(@args[0])
					@cop = player()
					@ip = pinfo(@plr)[3]
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}
				
				@profile = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/policedatabase.sqlite')
				@result = query(@profile, 'SELECT DISTINCT PERPNAME,IP FROM `criminals` WHERE IP=?',@ip)
				foreach(@row in @result){
					tmsg(@cop,@row['PERPNAME'])
				}			
		
		}
	)
)

register_command(backgroundcheck, 

	array(
	
		description: 'Checks for Information on a Player',
		
		usage: '/backgroundcheck <player>',
		
		permission: 'backgroundcheck',
		
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
					msg(''.color(RED).'Usage: /backgroundcheck <player>');
					die(); # No need to go further					
				
				}	

				try {
					@plr = player(@args[0])
					@cop = player()
					@uuid = puuid(@plr)
					@ip = pinfo(@plr)[3]
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}

				@profile = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/policedatabase.sqlite')
				@result = query(@profile, 'SELECT * FROM `criminals` WHERE PERPUUID=?',@uuid)
				@numOffenses = array_size(@result)
				foreach(@row in @result){
					tmsg(@cop,
						color(dark_red).'Offense Type: '.@row['TYPE'].color(yellow).' | '.
						color(red).'Perp Name: '.@row['PERPNAME'].color(yellow).' | '.
						color(gold).'Reason: '.@row['REASON'].color(yellow).' | '.
						color(aqua).'Officer: '.color(dark_aqua).@row['AO'].color(yellow).' | '.
						color(green).@row['DATE'])
					tmsg(@cop,'-----------------------------------------')
				}
				tmsg(@cop,'A total of '.@numOffenses.' warnings and offenses.')			
		
		}
	)
)

register_command(officerhistory, 

	array(
	
		description: 'Checks the Arrest and Warning History of an Officer',
		
		usage: '/officerhistory <player>',
		
		permission: 'officerhistory',
		
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
					msg(''.color(RED).'Usage: /officerhistory <player>');
					die(); # No need to go further					
				
				}				

				try {
					@plr = player(@args[0])
					@cop = player()
					@uuid = puuid(@plr)
					@ip = pinfo(@plr)[3]
				} catch (PlayerOfflineException @ErrorInfo) {				
					msg(@player,'Player: '.@plr.' is Offline')
					die()
				}			
				
				@profile = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/policedatabase.sqlite')
				@result = query(@profile, 'SELECT * FROM `criminals` WHERE OFFUUID=?',@uuid)
				@numOffenses = array_size(@result)
				foreach(@row in @result){
					tmsg(@cop,
						color(dark_red).'Offense Type: '.@row['TYPE'].color(yellow).' | '.
						color(red).'Perp Name: '.@row['PERPNAME'].color(yellow).' | '.
						color(gold).'Reason: '.@row['REASON'].color(yellow).' | '.
						color(aqua).'Officer: '.color(dark_aqua).@row['AO'].color(yellow).' | '.
						color(green).@row['DATE'])
					tmsg(@cop,'-----------------------------------------')
				}
				tmsg(@cop,'A total of '.@numOffenses.' warnings and offenses.')
		
		}
	)
)

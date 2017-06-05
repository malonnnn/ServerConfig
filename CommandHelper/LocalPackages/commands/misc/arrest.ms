register_command(arrest, 

    array(
        description: 'Arrests a player and Jails them',
        usage: '/arrest <player> <reason>',
        permission: 'ch.alias.arrest',
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
                    msg(''.color(RED).'Usage: /arrest <player> <reason>');
                    die(); # No need to go further					
                
                }
                
                try {
                    @plr = player(@args[0])					
                    @cop = player()
                    @vicUUID = puuid(@plr)
                    @ip = pinfo(@plr)[3]
                    
                    @reason = ''
                    @argsLength = array_size(@args)
					
					if(@cop[0] != '#') {
                    
						if(has_permission(@cop, 'is.suspended')) {
						
							msg(''.color(RED).color(BOLD).'You are currently suspended! Your powers of arrest have been revoked.');
							die();
						
						}
					
					}
					
					if(has_permission(@plr, 'ch.alias.onduty')){
					
						sudo("/pex user ".@plr." add is.suspended");
					
					}
					
                    for (@i = 1, @i < @argsLength, @i++){
                    
                        @reason = @reason.@args[@i].' '
                    
                    }
                    
                    @reason = trim(@reason)
                    
                    @date = simple_date('hh:mm aaa z',time(),'CST')

                    sudo('/sudo '.@plr.' c:/ch leave local')
                    sudo('/sudo '.@plr.' c:/ch join global')
                    include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
                    _mortal(@plr)
					
					if (@cop[0] == '#') {
						broadcast(@plr.color(red).' HAS BEEN ARRESTED BY '.color(white).'The Server'.color(red).' FOR '.color(yellow).@reason)
					} else {
						broadcast(@plr.color(red).' HAS BEEN ARRESTED BY '.color(white).@cop.color(red).' FOR '.color(yellow).@reason)					
					}

                    @profile = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/policedatabase.sqlite')
                    
                    @date = simple_date('yyyy-MM-dd HH:mm:ss', time())
					if (@cop[0] == '#') {
						@result = query(@profile,'INSERT INTO `criminals` '.
												 'VALUES(?,?,?,?,?,?,?,?)',
												 @plr,@vicUUID,@reason,'ARREST',@ip,@cop,'server-command-block',simple_date('yyyy-MM-dd HH:mm:ss', time())
						)
					} else {
						@result = query(@profile,'INSERT INTO `criminals` '.
												 'VALUES(?,?,?,?,?,?,?,?)',
												 @plr,@vicUUID,@reason,'ARREST',@ip,@cop,puuid(@cop),simple_date('yyyy-MM-dd HH:mm:ss', time())
						)
					}
                    bind(entity_damage,array(id: @plr.'criminalPoisonFeeding'),associative_array('id': @vicUUID,'cause': 'POISON'), @e, @player = @plr){
                        set_peffect(@player, 23, 2)
                        cancel()
                    }
                    set_timeout(3000,closure(
                        sudo("/pex user ".@plr." group set criminal")
                        sudo("/tptoggle ".@plr." off")
                        sudo("/warp quarantine ".@plr)						
                    ))			
                    set_timeout(5000,closure(
                        set_pmode(@plr,'SURVIVAL')						
                    ))			
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg('Player is Offline')
                    die()
                }				
                
                
        
        }
    )
)

register_command(release, 

    array(
    
        description: 'Release a player from Jail',
        
        usage: '/release <player>',
        
        permission: 'ch.alias.release',
        
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
                
                if(has_permission(player(), 'is.suspended')) {
                    
                        msg(''.color(RED).color(BOLD).'You are currently suspended! Your powers to release have been revoked.');
                        die();
                    
                    }
                
                try {
                    @plr = player(@args[0])
                    sudo("/pex user ".@plr." group set mortal")
                    sudo("/warp city ".@plr)
                    sudo("/tptoggle ".@plr." on")	
                    unbind(@plr.'criminalPoisonFeeding')
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg('Player is Offline')
                    die()
                }
                
        }
    )
)

register_command(warn, 

    array(
        description: 'Warns a player for Behavior and records Infraction',
        usage: '/warn <player> <reason>',
        permission: 'ch.alias.warn',
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
                    msg(''.color(RED).'Usage: /warn <player> <reason>');
                    die(); # No need to go further					
                
                }
                
                try {
                    @plr = player(@args[0])
                    @cop = player()
                    @uuid = puuid(@plr)
                    @ip = pinfo(@plr)[3]
                    
                    @reason = ''
                    @argsLength = array_size(@args)
                    
                    if(has_permission(@cop, 'is.suspended')) {
                    
                        msg(''.color(RED).color(BOLD).'You are currently suspended! Your powers to warn have been revoked.');
                        die();
                    
                    }
                    
                    for (@i = 1, @i < @argsLength, @i++){
                    
                        @reason = @reason.@args[@i].' '
                    
                    }
                    
                    @reason = trim(@reason)
                    
                    broadcast(color(bold).@plr.color(dark_red).color(bold).' HAS BEEN WARNED BY '.color(white).@cop.color(dark_red).color(bold).' ON THE GROUNDS OF '.color(yellow).@reason.color(red).color(bold).'. Please read '.color(dark_red).'/warp rules'.color(red).' and familiarize yourself with the server rules or you may end up jailed!')

                    @profile = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/policedatabase.sqlite')
                    query(@profile,'INSERT INTO `criminals` '.
                                   'VALUES(?,?,?,?,?,?,?,?)',
                                   @plr,@uuid,@reason,'WARN',@ip,@cop,puuid(@cop),simple_date('yyyy-MM-dd HH:mm:ss', time())
                    )			
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg('Player is Offline')
                    die()
                }				
                
                
        
        }
    )
)

register_command(checkfingerprints, 

    array(
        description: 'Checks for Information on a Player',
        usage: '/checkfingerprints <player>',
        permission: 'ch.alias.checkfingerprints',
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
                
                if(has_permission(@cop, 'is.suspended')) {
                    
                        msg(''.color(RED).color(BOLD).'You are currently suspended! You may not access the Police Database');
                        die();
                    
                }
                
                
                @ip = pinfo(@plr)[3]
                @profile = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/policedatabase.sqlite')
                @result = query(@profile, 'SELECT DISTINCT PERPNAME,IP FROM `criminals` WHERE IP=?',@ip)
                foreach(@row in @result){
                    tmsg(@cop,@row['PERPNAME'])
                }
            } catch (PlayerOfflineException @ErrorInfo) {				
                msg('Player is Offline')
                die()
            }                          
        
        }
    )
)

register_command(removerecord, 

    array(
        description: 'Removes a players record',
        usage: '/removerecord <player> <date> <time>',
        permission: 'ch.alias.removerecord',
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
        
            if (array_size(@args) != 3) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /removerecord <player> <date> <time>');
                die(); # No need to go further					
            
            }
            
			@plr = @args[0]
			@date = @args[1].' '.@args[2]
			@cop = player()                
			
			@profile = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/policedatabase.sqlite')
			query(@profile, 'DELETE FROM `criminals` WHERE PERPNAME=? AND DATE=?',@plr, @date)
			
			tmsg(@cop, 'Record deleted.');          			
        
        }
    )
)

register_command(removeallrecords, 

    array(
        description: 'Removes all criminal records for a player',
        usage: '/removeallrecords <uuid>',
        permission: 'ch.alias.removeallrecords',
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
                msg(''.color(RED).'Usage: /removeallrecords <uuid>');
                die(); # No need to go further					
            
            }
            
			@uuid = @args[0]			
			@cop = player()                
			
			@profile = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/policedatabase.sqlite')
			query(@profile, 'DELETE FROM `criminals` WHERE PERPUUID=?',@uuid)
			
			tmsg(@cop, 'All Records Deleted for UUID: '.@uuid);          			
        
        }
    )
)

register_command(backgroundcheck, 

    array(
        description: 'Checks for Information on a Player',
        usage: '/backgroundcheck <player>',
        permission: 'ch.alias.backgroundcheck',
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
                
                if(has_permission(@cop, 'is.suspended')) {
                    
                        msg(''.color(RED).color(BOLD).'You are currently suspended! You may not access the Police Database');
                        die();
                    
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
				
                
            } catch (PlayerOfflineException @ErrorInfo) {
                
                @player = player()
                
                msg(@player,'Player: '.@args[0].' is Offline')
                msg(@player,'Checking Offline Records')
                
                if(has_permission(@player, 'is.suspended')) {
                    
                        msg(''.color(RED).color(BOLD).'You are currently suspended! You may not access the Police Database');
                        die();
                    
                }
                
                @profile = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/policedatabase.sqlite')
                @result = query(@profile, 'SELECT * FROM `criminals` WHERE PERPNAME=?',@args[0])
                @numOffenses = array_size(@result)
                foreach(@row in @result){
                    tmsg(@player,
                        color(dark_red).'Offense Type: '.@row['TYPE'].color(yellow).' | '.
                        color(red).'Perp Name: '.@row['PERPNAME'].color(yellow).' | '.
                        color(gold).'Reason: '.@row['REASON'].color(yellow).' | '.
                        color(aqua).'Officer: '.color(dark_aqua).@row['AO'].color(yellow).' | '.
                        color(green).@row['DATE'])
                    tmsg(@player,'-----------------------------------------')
                }
                tmsg(@player,'A total of '.@numOffenses.' warnings and offenses.')
                tmsg(@player,'**OFFLINE RECORD**')
                
                die()
            }					
        
        }
    )
)

register_command(officerhistory, 

    array(
        description: 'Checks the Arrest and Warning History of an Officer',
        usage: '/officerhistory <player>',
        permission: 'ch.alias.officerhistory',
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
                
                if(has_permission(@cop, 'is.suspended')) {
                    
                        msg(''.color(RED).color(BOLD).'You are currently suspended! You may not access the Police Database');
                        die();
                    
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
            } catch (PlayerOfflineException @ErrorInfo) {				
                msg('Player is Offline')				
                die()
            }
        
        }
    )
)

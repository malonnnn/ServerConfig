register_command(onduty, 

    array(
    
        description: 'Used by Server Officer\'s to place themselves On Duty',
        
        usage: '/onduty',
        
        permission: 'ch.alias.onduty',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {			
                
            @player = player()
            @playersUUID = puuid(@player); # Store the players UUID which we use to identify them with variables stored in the register
            @playersGroup = pgroup(@player)[0]; # Store the players current group to be used with the offduty command 
    
            @keyPreviousGroup = 'police.'.@playersUUID.'.pgroup'; # Unique AFK key to store the previous
            export(@keyPreviousGroup, @playersGroup); # Store the previous group in the register				
            
            if(has_permission(@player,"is.sergeant")){
            
                set_timeout(3000,closure(
                    sudo("/pex user " . @player . " group set sergeant")
                    tmsg(@player,color(red)."You are now on duty!")
                ))
                
            }else if(has_permission(@player,'is.officer')){
                set_timeout(3000,closure(
                    sudo("/pex user " . @player . " group set officer")
                    tmsg(@player,color(red)."You are now on duty!")
                ))
                
            }else{
                tmsg(@player,color(red)."You are not part of the Police Force!")
            }              
        
        }
    )
)

register_command(offduty, 

    array(
    
        description: 'Used by Server Officer\'s to place themselves Off Duty',
        
        usage: '/offduty',
        
        permission: 'ch.alias.offduty',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {			
                
            @playerThatRanCmd = player();
            @playersUUID = puuid(@playerThatRanCmd); # Store the players UUID which we use to identify them with variables stored in the register
            @playersGroup = pgroup(@playerThatRanCmd)[0]; # Store the players current group
			
            @keyPreviousGroup = 'police.'.@playersUUID.'.pgroup'; # Unique AFK key to store the previous
            @playersPreviousGroup = import(@keyPreviousGroup); # Retrieves the previous group in the register				
            
            if (@playersPreviousGroup == null) {
            
                msg('Unable to determine your previous Hero Class. You will be mortalled instead. Sorry.');	
                include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
                _mortal(@playerThatRanCmd)

                die(); # Done
            
            } else {
			
				include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
				include('/home/minecraft/server/plugins/CommandHelper/includes/changeTrail.ms')
			
				try {
				
					include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @playersPreviousGroup . '.ms');
					
					if(@hero['op'] == "true"){
						
						if(acc_balance(@playerThatRanCmd) == 0){
						
							msg('You need at least $1 to use your former character');
							die();
							
						}
						
					}
					
					@allPlayers = all_players();
					
					foreach(@player in @allPlayers) {
					
						@playerGroup = pgroup(@player);
						
						if(@playerGroup[0] == @hero['class'] && @player != @playerThatRanCmd){
							
							msg('Someone else is using your previous Hero. You will be mortalled instead. Sorry.');	
							include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
							_mortal(@playerThatRanCmd)

							die(); # Done
							
						}
					}					
					
				} catch (IOException @ErrorInfo) {
				
					 sudo("/pex user " . @playerThatRanCmd . " group set ".@playersPreviousGroup); # Set the player back to their previous group. Probably not a hero
					 msg('You are now Off Duty! You have been restored to your previous Hero Class');
					 die(); 
				
				}              
                
                sudo("/pex user " . @playerThatRanCmd . " group set ".@playersPreviousGroup); # Set the player back to their previous hero
				msg('You are now Off Duty! You have been restored to your previous Hero Class');
            
            }                
        
        }
    )
)

register_command(suspendofficer, 

    array(
    
        description: 'Places an Officer under Suspension',
        
        usage: '/suspendofficer <player>',
        
        permission: 'ch.alias.suspendofficer',
        
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
				msg(''.color(RED).'Usage: /suspendofficer <player>');
				die(); # No need to go further					
			
			}
			
			try {
				@plr = player(@args[0])
				@player = player()
				
				sudo("/pex user ".@plr." add is.suspended")
				tmsg(@plr,color(red).'You have been suspended from your duties until further notice')
				tmsg(@player,color(red).'You have suspended '.@plr.' from his/her duties.')	
			} catch (PlayerOfflineException @ErrorInfo) {				
				msg(@player,'Player: '.@plr.' is Offline')
				die()
			}                         
        
        }
    )
)

register_command(reinstateofficer, 

    array(
    
        description: 'Remove an Officer\'s Suspension',
        
        usage: '/reinstateofficer <player>',
        
        permission: 'ch.alias.reinstateofficer',
        
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
				msg(''.color(RED).'Usage: /reinstateofficer <player>');
				die(); # No need to go further					
			
			}
			
			try {
				@plr = player(@args[0])
				@player = player()
				
				sudo("/pex user ".@plr." remove is.suspended")
				tmsg(@plr,color(red).'You have been restored to your full duties')
				tmsg(@player,color(red).'You removed '.@plr.'\'s suspension.')	
			} catch (PlayerOfflineException @ErrorInfo) {				
				msg(@player,'Player: '.@plr.' is Offline')
				die()
			}                         
        
        }
    )
)
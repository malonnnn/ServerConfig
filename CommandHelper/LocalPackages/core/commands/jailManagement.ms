proc(_CleanupJailTeam,

	@teamName = 'jail'; # Team name
	@scoreboardName = 'jail' # Scoreboard name
	@world = 'overvoid' # Jail world name
	
	@teams = get_teams(); 
	
	foreach(@team in @teams) {
	
		if (@team[name] == @teamName) { # Found team
		
			foreach(@player in @team[players]) {
			
				if(pworld(@player) != @world) {
				
					team_remove_player(@teamName, @player); # Cleanup - Remove players from the team if they aren't in the jail world
					
				}
			
			}
		}
	}

)

proc(_AddPlayerToJailTeam, @playerToAdd, 

	@teamName = 'jail'; # Team name
	@scoreboardName = 'jail' # Scoreboard name
	@world = 'overvoid' # Jail world name
	
	@teams = get_teams();
	 
	foreach(@team in @teams) {
	
		if (@team[name] == @teamName) {

			_CleanupJailTeam(); # Cleanup (Remove players no longer in the overvoid world)
			
			if(pworld(@playerToAdd) != @world) { 
				
				die(); # Don't add the player. Wrong world
			
			}
			
			if(!array_contains(@team[players], @playerToAdd)) { # Player isn't on team
			
				team_add_player(@teamName, @playerToAdd); # Add the player to the jail team
				set_pmode(@playerToAdd, SURVIVAL); # Ensure player is in survival mode
				die(); # Done
			
			}
			
			die(); # No need to check any further
		
		}
	
	}
	
	# Team doesn't exist
	create_team(@teamName); # Create the team
	team_add_player(@teamName, @playerToAdd); # Add the player to the team

)

proc(_RemovePlayerFromJailTeam, @playerToRemove, 

	@teamName = 'jail'; # Team name
	@scoreboardName = 'jail' # Scoreboard name
	@world = 'overvoid' # Jail world name
	
	@teams = get_teams();
	 
	foreach(@team in @teams) {
	
		if (@team[name] == @teamName) {	# Team exists
			
			if(array_contains(@team[players], @playerToRemove)) { # Found player on team
			
				team_remove_player(@teamName, @playerToRemove); # Remove the player from the jail team
				die(); # Done
			
			}
			
			_CleanupJailTeam(); # Cleanup (Remove players no longer in the overvoid world)
			
			die(); # No need to check any further
		
		}
	
	}
	
	# Team doesn't exist

)

register_command(jail_spawnskelly, 

    array(
	
		permission: 'ch.alias.jailskelly',
    
        executor: closure(@alias, @sender, @args) {
        
            @arguements = ''; # String of arguements
    
            if (array_size(@args) == 0) {       
                
                msg('Usage: jail_spawnskelly <playerThatTriggeredCommand>');
                die(); # Done
            
            } else {
                
                try {
                
                    @player = player(@args[0]); # Create a player object
					@playerLocation = ploc(@player); # Players location
					@playerLocation[y] += 1; # Increase the Y position 1 block above so we don't spawn the skelly into a block
					
					@skeletonsInArea = entities_in_radius(@playerLocation, 50, array(SKELETON)); # Number of Skeletons in area
					
					if (array_size(@skeletonsInArea) == 0) { # No Skellys in the area
					
						runas('~console', '/mm mobs spawn JailSkele 1 '.@playerLocation[world].','.@playerLocation[x].
							','.@playerLocation[y].','.@playerLocation[z]); # Spawn the jail Skelly					
					
					}
                    
                    die(); # Done
                    
                } catch (PlayerOfflineException @ErrorInfo) {
                
                    msg('The target player appears to be Offline');
                    die(); # Done
                
                }
            
            }	
        
        }
    )
)

register_command(jail_hunger_tp, 

    array(
	
		permission: 'ch.alias.hungertp',
    
        executor: closure(@alias, @sender, @args) {
    
            if (array_size(@args) != 6) {       
                
                msg('Usage: jail_hunger_tp <playerThatTriggeredCommand> <x> <y> <z> <pitch> <yaw>');
                die(); # Done
            
            } else {
                
                try {
                
                    @player = player(@args[0]); # Create a player object
					@teleportDestination = array(world: pworld(@player), x: @args[1], y: @args[2], z: @args[3], pitch: @args[4], yaw: @args[5]); # Teleport destination
					
					if (phunger(@player) <= 7) {
					
						set_ploc(@player, @teleportDestination); # Teleport Player
						tmsg(@player, color(GREEN).'Entered Safe Zone - Skeleton Free Area');
						_RemovePlayerFromJailTeam(@player); # Remove the player from he jail team so they aren't targeted by the skelly
						die()
					
					} else { 
					
						tmsg(@player, color(RED).'You are not Hungry Enough!');
						die()
					
					}
                    
                } catch (PlayerOfflineException @ErrorInfo) {
                
                    msg('The target player appears to be Offline');
                    die(); # Done
                
                }
            
            }	
        
        }
    )
)

register_command(jail_enter, 

    array(
	
		permission: 'ch.alias.jailenter',
    
        executor: closure(@alias, @sender, @args) {
    
            if (array_size(@args) != 6) {       
                
                msg('Usage: jail_enter <playerThatTriggeredCommand> <x> <y> <z> <pitch> <yaw>');
                die(); # Done
            
            } else {
                
                try {
                
                    @player = player(@args[0]); # Create a player object
					@teleportDestination = array(world: pworld(@player), x: @args[1], y: @args[2], z: @args[3], pitch: @args[4], yaw: @args[5]); # Teleport destination
										
					set_ploc(@player, @teleportDestination); # Teleport Player
					tmsg(@player, color(RED).'Welcome to Jail');
					_AddPlayerToJailTeam(@player); # Add the player to the jail team so the skelly targets them
					die();					
                    
                } catch (PlayerOfflineException @ErrorInfo) {
                
                    msg('The target player appears to be Offline');
                    die(); # Done
                
                }
            
            }	
        
        }
    )
)
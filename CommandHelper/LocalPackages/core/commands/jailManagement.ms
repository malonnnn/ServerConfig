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
        
            @arguements = ''; # String of arguements
    
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
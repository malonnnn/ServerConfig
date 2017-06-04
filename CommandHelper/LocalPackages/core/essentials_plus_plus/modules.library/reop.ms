proc(_deop, @playerThatRanCmd, @command,		

    @args = parse_args(@command); # Parse the arguements

    if (array_size(@args) != 2){
    
        die(); # Improper usage. Expecting /cmd <playername>
    
    }
    
    @player = player(@playerThatRanCmd); # Create a player object
    @playersUUID = puuid(@player); # Store the players UUID which we use to identify them with variables stored in the register		

    try {		
        
        if(pisop(@player) == true && @player == player(@args[1])) { # Player de-oped himself
        
            try {
        
            @database = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/essentials_plus_plus.sqlite'); # Database connection
            @sql = query(@database, 'INSERT OR IGNORE INTO `operators` (uuid) VALUES(?);',@playersUUID); # Add if not exists			
        
            } catch (SQLException @ErrorInfo) {
            
                msg(@player, 'SQL Error Occurred. Unable to create protected warp. See console for details');
                console('Essentials Plus Plus SQL Error: '.@ErrorInfo);
                return(true); # Cancel the original function
            
            }
            
            die(); # Done
            
        } else {
        
            die(); # Player isn't OP so who cares
        
        }	
    
    } catch (PlayerOfflineException @ErrorInfo) {
    
        die(); # Whatever
    
    }
)

register_command(reop, 

    array(   

        description: 'Restores a player to OP if they previously deoped themselves',        

        usage: '/reop',	    

        executor: closure() {            

            @playerThatRanCmd = player(); # Create a player object
            @playersUUID = puuid(@playerThatRanCmd); # Store the players UUID which we use to identify them with variables stored in the register
            
            try {
        
                @database = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/essentials_plus_plus.sqlite'); # Database connection
                @sql = query(@database, 'SELECT * FROM `operators` WHERE `uuid`=?;',@playersUUID); # Check for the operator record

                foreach(@result in @sql){
                
                    if(@playersUUID == @result[uuid]){
                    
                        # Perfect! Let's re-op the player
                        runas(~console, '/op '.@playerThatRanCmd); # OP						
                        @sql = query(@database, 'DELETE FROM `operators` WHERE `uuid`=?;',@playersUUID); # Clear the Previous OP Status to prevent a player from re-opping themselves if they were deoped by someone else
                        msg('Opped '.@playerThatRanCmd);
                        die(); # Done					
                    
                    }
                
                }
                
                msg(color(RED).'Command Failed! Unable to determine if you were previously an OP'); # Let the player know the bad news
                die();				
        
            } catch (SQLException @ErrorInfo) {
                
                msg(@player, 'SQL Error Occurred. Unable to delete protected warp. See console for details');
                console('Essentials Plus Plus SQL Error: '.@ErrorInfo);
                return(true); # Cancel the original function
                
            }            

        }
    )
)

bind(player_command, null, array(prefix: '/deop'), @Event, 
    
	_deop(@Event[player], @Event[command]); # Puff puff pass
    
)
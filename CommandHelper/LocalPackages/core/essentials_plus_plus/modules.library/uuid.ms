# --------------------------------------------------------------------------
# Retrieve a players UUID
# --------------------------------------------------------------------------

register_command(uuid, 

    array(
    
        description: 'Displayers a players UUID',
        
        usage: '/uuid',		
    
        executor: closure(@alias, @sender, @args) {
        
            @arguements = ''; # String of arguements
    
            if (array_size(@args) == 0) {
            
                @player = player(); # Create a player object
                @playersUUID = puuid(@player); # Store the players UUID
                msg('Your UUID is: '.@playersUUID);
                die(); # Done
            
            } else {
                
                try {
                
                    @player = player(@args[0]); # Create a player object
                    @playersUUID = puuid(@player); # Store the players UUID
                    
                    msg('The UUID for '.@player.' is: '.@playersUUID);
                    die(); # Done
                    
                } catch (PlayerOfflineException @ErrorInfo) {
                
                    msg('The player you selected appears to be Offline');
                    die(); # Done
                
                }
            
            }	
        
        }
    )
)
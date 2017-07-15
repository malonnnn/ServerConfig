# --------------------------------------------------------------------------
# Generates a URL using the players UUID to retrieve the skin Sigature and Value
# --------------------------------------------------------------------------

register_command(signature, 

    array(
    
        description: 'Generate a link to grab the players signature and value',
        
        usage: '/signature',		
    
        executor: closure(@alias, @sender, @args) {
        
            @arguements = ''; # String of arguements
    
            if (array_size(@args) == 0) {
            
                @player = player(); # Create a player object
                @playersUUID = puuid(@player, true); # Store the players UUID
                msg('Your Signature Link is: https://sessionserver.mojang.com/session/minecraft/profile/'.@playersUUID.'?unsigned=false');
                die(); # Done
            
            } else {
                
                try {
                
                    @player = player(@args[0]); # Create a player object
                    @playersUUID = puuid(@player,true); # Store the players UUID
                    
                    msg('Signature Link for '.@player.' is: https://sessionserver.mojang.com/session/minecraft/profile/'.@playersUUID.'?unsigned=false');
                    die(); # Done
                    
                } catch (PlayerOfflineException @ErrorInfo) {
                
                    msg('The player you selected appears to be Offline');
                    die(); # Done
                
                }
            
            }	
        
        }
    )
)

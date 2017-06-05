# --------------------------------------------------------------------------
# AFK functions to be able to set a players AFK status
# --------------------------------------------------------------------------

include('broadcastReplace.ms');

# Sets a player to AFK
proc(_setafk, @playerName, @silent,	

    @player = player(@playerName); # If player is a string, convert it to a player object		
    
    @playersUUID = puuid(@player); # Store the players UUID which we use to identify them with variables stored in the register
    
    @keyAFKStatus = 'epp.'.@playersUUID.'.afk'; # Unique AFK key to store the status of AFK
    @keyMoveBind = 'epp.'.@playersUUID.'.afkmovebind'; # Unique AFK key to store the status of AFK
    @keyAFKPlayers = 'epp.afkplayers'; # Unique AFK key to store a list of currently AFK players
    
    @afkPlayers = import(@keyAFKPlayers, array()); # Import a list of currently AFK players, if it doesn't exist then create it
    array_push(@afkPlayers, @player); # Add the player to the array of AFK players
    @afkPlayers = array_unique(@afkPlayers, false); # Clean up the array if there are duplicates. Remove duplicates and don't compare data types (ie. integer, string)
    export(@keyAFKPlayers, @afkPlayers); # Store the array of players in the global register
    
    # Change status to AFK			
    export(@keyAFKStatus, true); # Set key to true
    
    set_list_name(@player, '§7§o[AFK] §7§m§o'.@player.'§r') # Change the scoreboard name to AFK with strike-through
    set_display_name(@player, '§7§o[AFK] §7§m§o'.@player.'§r') # Change the /list name to AFK with strike-through
    
    if (@silent == false) {		
    
        _broadcast('&c&o* '.@player.' is now AFK') # Tell everyone that the player is now AFK
        
        @id = bind(player_move, null, array(threshold: 2, player: @player), @Event, 
        
            @playersUUID = puuid(@Event[player]); # Store the players UUID which we use to identify them with variables stored in the register
            @keyAFKStatus = 'epp.'.@playersUUID.'.afk'; # Unique AFK key to store the status of AFK
            
            export(@keyAFKStatus, false); # Set key to false
            set_display_name(@Event[player], @Event[player]); # Change the /list name back to the original name (remove AFK status)
            set_list_name(@Event[player], null); # Reset the scoreboard to show the players original name (remove AFK status)			
            
            _broadcast('&a&o* '.@Event[player].' is no longer AFK') # Tell everyone that the player is back!
            
            @keyAFKPlayers = 'epp.afkplayers'; # Unique AFK key to store a list of currently AFK players
            @afkPlayers = import(@keyAFKPlayers, null); # Import a list of currently AFK players, if it doesn't exist then set it to null
            if (@afkPlayers != null) {
            
                array_remove_values(@afkPlayers, @Event[player]); # Remove the player from the global list
                export(@keyAFKPlayers, @afkPlayers); # Store the array of players in the global register

            }	
            
            unbind(); # Remove the bind
        )
        
        export(@keyMoveBind, @id); # Store the ID of the binded move event so we can cancel it if need be
        
    } else {
    
        @id = bind(player_move, null, array(threshold: 2, player: @player), @Event, 
        
            @playersUUID = puuid(@Event[player]); # Store the players UUID which we use to identify them with variables stored in the register
            @keyAFKStatus = 'epp.'.@playersUUID.'.afk'; # Unique AFK key to store the status of AFK
            
            export(@keyAFKStatus, false); # Set key to false
            set_display_name(@Event[player], @Event[player]); # Change the /list name back to the original name (remove AFK status)
            set_list_name(@Event[player], null); # Reset the scoreboard to show the players original name (remove AFK status)
            
            unbind(); # Remove the bind
        )
        
        export(@keyMoveBind, @id); # Store the ID of the binded move event so we can cancel it if need be
        
    }
    
)

# Removes a players AFK status
proc(_remafk, @playerName, @silent,

    @player = player(@playerName); # If player is a string, convert it to a player object		
    @playersUUID = puuid(@player); # Store the players UUID which we use to identify them with variables stored in the register
    
    @keyAFKStatus = 'epp.'.@playersUUID.'.afk'; # Unique AFK key to store the status of AFK
    @keyMoveBind = 'epp.'.@playersUUID.'.afkmovebind'; # Unique AFK key to store the status of AFK
    @keyAFKPlayers = 'epp.afkplayers'; # Unique AFK key to store a list of currently AFK players

    @afkPlayers = import(@keyAFKPlayers, null); # Import a list of currently AFK players, if it doesn't exist then set it to null
    if (@afkPlayers != null) {
    
        array_remove_values(@afkPlayers, @player); # Remove the player from the global list
        export(@keyAFKPlayers, @afkPlayers); # Store the array of players in the global register

    }
            
    # Remove AFK
    export(@keyAFKStatus, false); # Set key to false
    @id = import(@keyMoveBind); # Import the id of the player_move bind
    
    if (@id != null){
    
        try{
        
            unbind(@id); # Try to unbind the player_move event
        
        } catch (BindException @ErrorInfo) {
        
            # Ignore (Bind probably doesnt exist, no worries)
        
        }
    
    }
    
    set_display_name(@player, @player); # Change the /list name back to the original name (remove AFK status)
    set_list_name(@player, null); # Reset the scoreboard to show the players original name (remove AFK status)
    
    if (@silent == false) {
    
        _broadcast('&a&o* '.@player.' is no longer AFK') # Tell everyone that the player is back!
        
    }
    
)
# --------------------------------------------------------------------------
# Complete /afk replacement with added features such as
# Visual indicators in /list menu and tabbed players menu.
# Ability to set an away msg with /afk <awayMsg>
# Visual and Audio notification to players that attempt to chat with an
# afk player
# --------------------------------------------------------------------------

include('includes/afkFunctions.ms'); # Include functions that allow us to set or remove afk for a player

# AFK Hook
proc(_afk, @playerThatRanCmd, @command,

    @args = parse_args(@command); # Parse the arguements
    @message = ''; # Start a blank message
    @numberOfArguements = array_size(@args); # Store the size for optimization when used in the loop (So it's not re-evaluated each time)

    if (@numberOfArguements > 1) {
    
        for(@i = 1, @i < @numberOfArguements, @i++) {
        
            @message = @message.' '.@args[@i]; # Add the string to the message (lets re-construct what msg the player sent)
        
        }
    
        @message = trim(@message); # Clean up the white space			
    
    } else {
    
        @message = null; # No message to construct			
    
    }
        
    @playersUUID = puuid(@playerThatRanCmd); # Store the players UUID which we use to identify them with variables stored in the register
    
    @keyAFKStatus = 'epp.'.@playersUUID.'.afk'; # Unique AFK key to store the status of AFK		
    @keyAFKMsg = 'epp.'.@playersUUID.'.afkmsg'; # Unique AFK key to store the msg of the AFK player	
    @isPlayerAFK = import(@keyAFKStatus, false); # Check the status, default to false if none found
    
    if(@isPlayerAFK == true){
    
        # Remove AFK
        export(@keyAFKMsg, null); # Clear the player's away message if it was supplied
        _remafk(@playerThatRanCmd, false); 			
    
    } else {
    
        # Change status to AFK
        export(@keyAFKMsg, @message); # Save the players away message
        
        if (@message != null) {
        
            tmsg(@playerThatRanCmd, color(GRAY).color(ITALIC).'Away Message Set to: '.@message)
        
        } else {
        
            tmsg (@playerThatRanCmd, color(GRAY).color(ITALIC).'*HINT* You can set an away msg by doing /afk <msg>')

        }			
        
        _setafk(@playerThatRanCmd, false);
        
    }	
)

bind(player_chat, null, null, @Event, 

    @playerTalking = player(@Event[player]); # Store the person chatting
    
    @afkPlayers = import('epp.afkplayers', null); # Import a list of currently AFK players
    
    if (@afkPlayers != null) { # If there are AFK players
    
        foreach(@player in @afkPlayers) {
        
            @regExpression = "([\\s]*)".@player."([\\s]*)"; # Generate the regular expression to check if another player is trying to msg an AFK player			
            @match = reg_match(@regExpression, @Event[message]); # Check for a match
            
            if (array_size(@match) > 0) { # Found a match
            
                tmsg(@playerTalking, color(GOLD).'*AFK WARNING*'color(WHITE).@player.color(GOLD).' is currently AFK'); # Msg the person who tried to chat to the AFK player	
                
                @keyAFKMsg = 'epp.'.puuid(@player).'.afkmsg'; # Unique AFK key to store the msg of the AFK player
                @awayMsg = import(@keyAFKMsg, null); # Try to retrieve the away msg if one exists
                
                if (@awayMsg != null) {
                
                    tmsg(@playerTalking, color(GOLD).'[Away Msg]: '.color(WHITE).color(ITALIC).@awayMsg); # Show the person who tried to chat to the AFK player the away msg
                
                }			
                
                play_sound(ploc(@playerTalking), array(sound: NOTE_PLING, volume: 100), @playerTalking); # Play a sound to alert the player
            
            }			
        
        }	
    }
    
)

bind(player_quit, null, null, @Event, 
        
    @playerName = @Event[player]; # The name of the player that just joined the server
    @playersUUID = puuid(@playerName); # The UUID of the player that just joined
    
    # --------------------------------------------------------------------------
    # AFK Reset
    # --------------------------------------------------------------------------
    export('epp.'.@playersUUID.'afk', false); # Set player's AFK status to false		
    @id = import('epp.'.@playersUUID.'.afkmovebind'); # Imort the ID of the move_player bind if it exists for the player that just joined
    
    if (@id != null){
    
        try{
        
            unbind(@id); # Try to unbind the player_move event
        
        } catch (BindException @ErrorInfo) {
        
            # Ignore (Bind probably doesnt exist, no worries)
        
        }
    
    }
    
    @keyAFKPlayers = 'epp.afkplayers'; # Unique AFK key to store a list of currently AFK players
    @afkPlayers = import(@keyAFKPlayers, null); # Import a list of currently AFK players, if it doesn't exist then set it to null
    if (@afkPlayers != null) {
    
        array_remove_values(@afkPlayers, @playerName); # Remove the player from the global list
        export(@keyAFKPlayers, @afkPlayers); # Store the array of players in the global register

    }	
)

bind(player_command, null, array(prefix: '/afk'), @Event,
    
    if (has_permission(@Event[player], 'essentials.afk')) {
    
        _afk(@Event[player], @Event[command]) # Pass to new function
        cancel() # Over-ride the pre-existing afk code (eesentials)
        
    }  
    
)

# --------------------------------------------------------------------------
# Automatic Functions / Code
# --------------------------------------------------------------------------

# AFK Loop to Check if player has moved in a certain amount of time
# More efficient than hooking into the player_move bind
# Check player locations once every 30 seconds

set_interval(30000, closure() {

    @allPlayers = all_players(); # Get all the players
    
    foreach(@player in @allPlayers){
    
        try {			
        
            @playerName = player(@player); # Grab the players name
            @playerUUID = puuid(@playerName); # Grab the players UUID
            
            @keyAFKStatus = 'epp.'.@playerUUID.'.afk'; # Unique AFK key to store the status of AFK
            
            if (import(@keyAFKStatus, false) == true) {
            
                # Player is already set to AFK so no need to go further
                continue(); # Next please
                
            }			
            
            @playerLocation = ploc(@playerName); # Grab the players current location		
            @keyLastKnownLocation = 'epp.'.@playerUUID.'.LastKnownLocation'; # Generate the key to store the players last known location
            @keyLastTimeLocationChecked = 'epp.'.@playerUUID.'.LastTimeLocationChecked'; # Generate the key to store the last time the players location was checked			
            
            @lastKnownLocation = import(@keyLastKnownLocation); # Check for the last known recorded position of the player
            @lastTimeLocationChecked = import(@keyLastTimeLocationChecked, 0); # Check to see when the players location was last checked. Set to 0 if never checked (Each check is done in minutes)
            
            if (@lastKnownLocation == null || @playerLocation != @lastKnownLocation) {				
            
                # There is no last known location, or the last known location has changed so let's update it
                export(@keyLastKnownLocation, @playerLocation); # Store the last known location of the player
                export(@keyLastTimeLocationChecked, 0); # Reset the last time checked count and store it in the register
                continue; # Carry on with another player
            
            } else {				
            
                if (@lastTimeLocationChecked >= 10) { # If the player hasn't moved in 5 minutes then silently set them to afk		
            
                    # 5 Minutes have passed and the player hasn't moved
                    # Set the player to AFK
                    _setafk(@playerName, true); # Set the players status to AFK, but do it silently (Better integration, works along-side pre-existing AFK from Essentials)
                    continue; # Carry on with another player
            
                } else {				
                
                    @lastTimeLocationChecked += 1; # Increase the check count by 1
                    export(@keyLastTimeLocationChecked, @lastTimeLocationChecked); # Store the last time the player was checked
                    continue; # Carry on with another player
                
                }
            
            }
        
        } catch (PlayerOfflineException @ErrorInfo) {
        
            # Who cares
            continue;
        
        }
    
    }
    
})

# --------------------------------------------------------------------------
# Reset (If /reloadaliases is used)
# --------------------------------------------------------------------------

set_timeout(100, closure() {

        foreach(@player in all_players()){
        
            set_display_name(@player, player(@player)); # Change the /list name back to the original name (remove AFK status)
            set_list_name(@player, null); # Reset the scoreboard to show the players original name (remove AFK status)
        
        }
        
    }
)
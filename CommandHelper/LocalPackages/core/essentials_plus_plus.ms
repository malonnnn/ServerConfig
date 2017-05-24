# --------------------------------------------------------------------------
# Registered Commands
# --------------------------------------------------------------------------

register_command(reop, 

	array(
	
		description: 'Restores a player to OP if they previously deoped themselves',
		
		usage: '/reop',		
	
		executor: closure() {
			
			@playerThatRanCmd = player(); # Create a player object
			@playersUUID = puuid(@playerThatRanCmd); # Store the players UUID which we use to identify them with variables stored in the register

			@keyPreviousOPStatus = replace('epp.'.@playersUUID.'.opstatus', '-', '_'); # Unique AFK key to store the OP status of a player. Hyphens must be changed to underscores to work
			
			@OPStatus = get_value(@keyPreviousOPStatus); # Get the value stored on the server regrding the players previous OP status 
		
			if (@OPStatus == true) {
			
				# Perfect! Let's re-op the player
				sudo('/op '.@playerThatRanCmd); # OP
				clear_value(@keyPreviousOPStatus); # Clear the Previous OP Status to prevent a player from re-opping themselves if they were deoped by someone else
				die(); # Done
			
			} else {
			
				msg(color(RED).'Command Failed! Unable to determine if you were previously an OP'); # Let the player know the bad news
				die(); # No need to go any further
			
			}			
		
		}
	)
)

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


# --------------------------------------------------------------------------
# Over-Ride Functions
# --------------------------------------------------------------------------

# Helper Function (Rainbow Text)
proc(_rainbowText, @textToColorize, 

	@tempText = string(@textToColorize);
	@tempTextSize = length(@tempText);
	
	@rainbowText = ''; # Placeholder for finalized string
	
	for (@i = 0, @i < @tempTextSize, @i++) {
	
		@rainbowText = @rainbowText.'&'.rand(1, 9).@tempText[@i]; # Build the rainbow string
	
	}

	return(@rainbowText); # Pass back the finished product
	
)


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
	
		broadcast(colorize('&c&o* '.@player.' is now AFK')) # Tell everyone that the player is now AFK
		
		@id = bind(player_move, null, array(threshold: 2, player: @player), @Event, 
		
			@playersUUID = puuid(@Event[player]); # Store the players UUID which we use to identify them with variables stored in the register
			@keyAFKStatus = 'epp.'.@playersUUID.'.afk'; # Unique AFK key to store the status of AFK
			
			export(@keyAFKStatus, false); # Set key to false
			set_display_name(@Event[player], @Event[player]); # Change the /list name back to the original name (remove AFK status)
			set_list_name(@Event[player], null); # Reset the scoreboard to show the players original name (remove AFK status)			
			
			broadcast(colorize('&a&o* '.@Event[player].' is no longer AFK')) # Tell everyone that the player is back!
			
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
	
		broadcast(colorize('&a&o* '.@player.' is no longer AFK')) # Tell everyone that the player is back!
		
	}
	
)

# Deop Hook
proc(_deop, @playerThatRanCmd, @command,		

	@args = parse_args(@command); # Parse the arguements

	if (array_size(@args) != 2){
	
		die(); # Improper usage. Expecting /cmd <playername>
	
	}
	
	@player = player(@playerThatRanCmd); # Create a player object
	@playersUUID = puuid(@player); # Store the players UUID which we use to identify them with variables stored in the register		
	@keyPreviousOPStatus = replace('epp.'.@playersUUID.'.opstatus', '-', '_'); # Unique AFK key to store the OP status of a player. This can be used to allow the player to /reop themselves	

	try {		
		
		if(pisop(@player) == true && @player == player(@args[1])) { # Player de-oped himself
		
			# Set the players previous op status to true and store in a persistent state in case server shuts down
			store_value(@keyPreviousOPStatus, true); # Key can't contain hyphens so we converted them to underscores earlier
			
			include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms');
			_mortal(@player);
			
			die(); # Done
			
		} else {
		
			die(); # Player isn't OP so who cares
		
		}	
	
	} catch (PlayerOfflineException @ErrorInfo) {
	
		die(); # Whatever
	
	}
)

# Help Hook
proc(_help, @playerThatRanCmd, @command,		

	@args = parse_args(@command); # Parse the arguements
	
	if (array_size(@args) > 2) {
		
		msg(''.color(RED).color(BOLD).'Improper Usage!');
		msg(''.color(RED).'Usage: /help <page number>');
		die(); # No need to go further					
		
	}
		
	@playerThatRanCmd = player();
		
	@internalCommands = get_commands()
	@commands = array();
	
	foreach (@command in @internalCommands) {		
		
		@commandString = '&b/'.@command[name].' &f- &f&o'.@command[description];
		array_push(@commands, @commandString);							
	
	}	
	
	if( @commands == null ) {
	
		@commands = array();
		
	}

	array_sort(@commands, 'STRING_IC');

	@perpage = 10;
	@page = 1;
	
	if (array_size(@args) == 2) {
	
		if (is_integral(@args[1])){
		
				@page = @args[1];
				
		} else {
		
			msg('Page Number must be a valid Number. Page set to: Pg #1');
			@page = 1;				
		
		}
		
	}			
	
	@maxpage = ceil(array_size(@commands) / @perpage);
	
	if(!is_integral(@page) || @maxpage == 0) {
	
		@maxpage = 1;
		
	}

	### If the page number is less than 1, or higher than the maximum page ###
	if(@page > @maxpage) {
	
		@page = @maxpage; # The idiot has entered a page that doesn't exist, so just give them the last page.
		
	} else if (@page < 1) {
	
		@page = 1; # Page cant be less than 1 so set it to the first page
	
	}

	@finalList = array();

	for(@i = (@page - 1) * @perpage, @i < (@page * @perpage), @i++) {
	
		if(array_size(@commands) > @i) {
		
			array_push(@finalList, @commands[@i]);
			
		}
		
	}
	
	msg(colorize("&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l="));
	msg(colorize("&4&l&k!&c&l&k!&4&l&k! &e&lDC&r &7- &4&lMarvel &7- &6&lAnime &7- &b&lV.Games &7- &d&lMore &4&l&k!&c&l&k!&4&l&k!"));
	msg(colorize("&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l="));
	msg(colorize("&3&oAvailable Commands: (". array_size(@commands). ") &7&o(Page: @{page}/@{maxpage})"));
	msg(''); # Insert Blank Line
	
	foreach (@command in @finalList){
	
		msg(colorize(@command));
		
	}
	
	if (@page != @maxpage){
	
		msg(''); # Insert Blank Line
		msg(colorize("&3&oType: &f&o/help ".(@page + 1)." &3&oto Goto the Next Page"));
	
	}
		
)

# Set Warp Hook
proc(_setwarp, @playerName, @command,

	@args = parse_args(@command); # Parse the arguements

	if (array_size(@args) <= 2) {	
		
		return(false); # Tell the original function to go ahead (Player didn't supply a third arguement)
		
	}
	
	if(@args[2] == 'locked') {
	
		@player = player(@playerName); # If player is a string, convert it to a player object
		@playersWorld = pworld(@player); # Store the world name of the player
	
		@keyProtectedWarps = 'epp.protectedwarps'; # Unique key to store a list of protected warps			
		@protectedWarps = get_value(@keyProtectedWarps); # Grab the list of protected warps
		
		if (is_array(@protectedWarps) == true) {

			array_push(@protectedWarps, array(warp: @args[1], world: @playersWorld)); # Place the info about the protected warp into the array of warps
			@protectedWarps = array_unique(@protectedWarps); # Remove duplicates
		
		} else {
		
			@protectedWarps = array(); # Create an empty array
			array_push(@protectedWarps, array(warp: @args[1], world: @playersWorld)); # Place the info about the protected warp into the array of warps
			
		}
		
		store_value(@keyProtectedWarps, @protectedWarps); # Store the list of warps
		runas(@player, '/setwarp '.@args[1]); # Re-run the command without the unlock arguement since we already have the warp saved
		
		return(true); # Tell the original function to cancel, we'll take it from here (it's being re-run anyways)
		
	} else {
	
		return(false); # Tell the original function to go ahead
	
	}
		
)

# Del Warp Hook
proc(_delwarp, @playerName, @command,

	@args = parse_args(@command); # Parse the arguements

	if (array_size(@args) < 2) {	
		
		return(false); # Tell the original function to go ahead	
		
	}
	
	@player = player(@playerName); # If player is a string, convert it to a player object

	@keyProtectedWarps = 'epp.protectedwarps'; # Unique key to store a list of protected warps			
	@protectedWarps = get_value(@keyProtectedWarps); # Grab the list of protected warps
	
	if (is_array(@protectedWarps) == true) {
	
		for(@i = 0, @i < array_size(@protectedWarps), @i++) {
		
			@warp = @protectedWarps[@i]
		
			if (@warp[warp] == @args[1]) {
			
				array_remove(@protectedWarps, @i); # Remove the warp
				store_value(@keyProtectedWarps, @protectedWarps); # Save the new list
				break; # Done
			
			}
		
		}
	
	}
	
	return(false);
		
)

# Warp Hook
proc(_warp, @playerName, @command,

	@args = parse_args(@command); # Parse the arguements
	
	if (array_size(@args) < 2) {	
		
		return(false); # Tell the original function to go ahead	
		
	}
	
	@player = player(@playerName); # Store the name of the player that ran the command

	@keyProtectedWarps = 'epp.protectedwarps'; # Unique key to store a list of protected warps			
	@protectedWarps = get_value(@keyProtectedWarps); # Grab the list of protected warps
	
	if (is_array(@protectedWarps) == true) {

		foreach(@warp in @protectedWarps) {

			if (@warp[warp] == @args[1]) {
			
				@permission = 'multiverse.access.'.@warp[world];
				sudo('/pex user '.@player.' add '.@permission); # Give access to the world
				set_timeout(1500, closure(sudo('/pex user '.@player.' remove '.@permission))) # Remove access 3 seconds later
			}
		}
	
	}
	
	return(false); # Tell the function to go ahead
)


# --------------------------------------------------------------------------
# Command Over-Rides
# --------------------------------------------------------------------------

bind(player_command, null, null, @Event, 

	# HOOKED COMMANDS _---------------------------
	if (@Event[prefix] == "/afk") {
	
		if (has_permission(@Event[player], 'essentials.afk')) {
		
			_afk(@Event[player], @Event[command]) # Pass to new function
			cancel() # Over-ride the pre-existing afk code (eesentials)
			
		}
		
	}
	
	
	if (@Event[prefix] == "/deop") {
	
		_deop(@Event[player], @Event[command]); # Puff puff pass
		
	}		
	
	if (@Event[prefix] == "/help") {
		
		_help(@Event[player], @Event[command]); # Puff puff pass	
		cancel() # Over-ride the pre-existing help code (eesentials)				
		
	}
	
	if (@Event[prefix] == "/setwarp") {
	
		if (has_permission(@Event[player], 'essentials.setwarp')) {
		
			if (_setwarp(@Event[player], @Event[command]) == true) {
			
				cancel() # Over-ride the pre-existing warp code (eesentials) only if told to do so
			
			}
			
		}
		
	}
	
	if (@Event[prefix] == "/delwarp") {	
		
	
		if (has_permission(@Event[player], 'essentials.delwarp')) {
		
			if (_delwarp(@Event[player], @Event[command]) == true) {
			
				cancel() # Over-ride the pre-existing warp code (eesentials) only if told to do so
			
			}
			
		}
		
	}
	
	if (@Event[prefix] == "/warp") {
	
		if (has_permission(@Event[player], 'essentials.warp')) {
		
			if (_warp(@Event[player], @Event[command]) == true) {
			
				cancel() # Over-ride the pre-existing warp code (eesentials) only if told to do so
			
			}
		
		}
		
	}		
	
	# DISABLED COMMANDS ---------------------------
	
	@disabledCmds = array('/jail', '/deljail', '/togglejail', '/setjail', '/jails');
	
	foreach(@command in @disabledCmds){
	
		if (@Event[prefix] == @command) {
		
			msg(color(RED).'That command has been disabled and is not in use on this server.'); # Tell the player
			cancel(); # Cancel the command since its in the disabled list
		
		}
	
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

# --------------------------------------------------------------------------
# Helper Functions / Code
# --------------------------------------------------------------------------

# AFK Loop to Check if player has moved in a certain amount of time
# More efficient than hooking into the player_move bind
# Check player locations once every minute and 10 seconds to see if they moved
# The additional 10 seconds allows the command to stay slightly ahead of the built-in essentials afk timer so they compliment one another
set_interval(75000, closure() {

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
			
				if (@lastTimeLocationChecked >= 4) { # If the player hasn't moved in 5 minutes or 4 checks then silently set them to afk		
			
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

# --------------------------------------------------------------------------
# Pre-Defined Functions
# --------------------------------------------------------------------------

# Takes a string of text and returns it with random color codes to be used with colorize()
proc(_rainbowText, @textToColorize, 

	@tempText = string(@textToColorize);
	@tempTextSize = length(@tempText);
	
	@rainbowText = ''; # Placeholder for finalized string
	
	for (@i = 0, @i < @tempTextSize, @i++) {
	
		@rainbowText = @rainbowText.'&'.rand(1, 9).@tempText[@i]; # Build the rainbow string
	
	}
	
	@rainbowText = @rainbowText.'&r'; # Add the reset tag at the end

	return(@rainbowText); # Pass back the finished product
	
)

# Uberslaps a player
proc(_uberSlap, @player, @target,
	
	@playerThatRanCmd = player(@player);
	@targetPlayer = player(@target);
	
	set_pvelocity(@targetPlayer, rand(-5, 5), rand(), rand(-5, 5))
	play_sound(ploc(@targetPlayer), array(sound: HURT_FLESH, volume: 100), @targetPlayer)
	
	if (@playerThatRanCmd != @targetPlayer) {
	
		play_sound(ploc(@playerThatRanCmd), array(sound: HURT_FLESH, volume: 100), @playerThatRanCmd);
	
	}
	
	if (pinfo(@targetPlayer, 5) > 1){
	
		set_phealth(@targetPlayer, double(pinfo(@targetPlayer, 5)) - 0.1);
		
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

# --------------------------------------------------------------------------
# Registered Commands
# --------------------------------------------------------------------------

register_command(copybook, 

    array(   

        description: 'Creates a duplicate copy of the book held in the players hand',        

        usage: '/copybook',
		
		permission: 'essentials.copybook',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) > 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /copybook [number of copies]');
                die(); # No need to go further					
            
            }

			@numberOfCopies = 1; # Assume we are making 1 copy
			
			try {
			
				@numberOfCopies = integer(@args[0]); # Grab the requested number of copies
				
				if (@numberOfCopies > 64) {
				
					msg(''.color(RED).'Number of Copies Must be Between 1-64');
					die(); # Done
				
				}				
				
			} catch (CastException @ErrorInfo) {
			
				msg(''.color(RED).'Improper Usage! Number of Copies must be a Number between 1-64');
				die(); # Done
			
			} catch (IndexOverflowException @ErrorInfo) {
			
				@numberOfCopies = 1; # Player didnt specify how many copies, Create 1			
			
			}

            @playerThatRanCmd = player(); # Create a player object
			
			@allowedBooks = array(340, 386, 387, 403); # Id's of each type of book allowed
			@slotHighlighted = pheld_slot(@playerThatRanCmd)
			@itemInHand = pinv(@playerThatRanCmd, @slotHighlighted)[type]; # Grab the ID of the item in the players hand
			
			if(array_contains(@allowedBooks, @itemInHand)){
			
				@itemMeta =  get_itemmeta(@slotHighlighted); # Grab the meta data
				msg(@itemMeta)
				pgive_item(@playerThatRanCmd, @itemInHand, @numberOfCopies, @itemMeta); # Create the copies and give it to the player
				die(); # All done				
			
			} else {
			
				msg('The Item you are Holding must be a Book'); # Scold the player for wasting time
				die(); # Finished
			
			}			

        }
    )
)

register_command(sendbook, 

    array(
    
        description: 'Send a book to another Player',
        
        usage: '/sendbook <player>',
        
        permission: 'essentials.sendbook',
        
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
                msg(''.color(RED).'Usage: /sendbook <player>');
                die(); # No need to go further					
            
            }

			@playerThatRanCmd = player(); # Create a player object
			@playerToSendTo = @args[0]; # Recipient
			
			@allowedBooks = array(340, 386, 387, 403); # Id's of each type of book allowed
			@slotHighlighted = pheld_slot(@playerThatRanCmd)
			@itemInHand = pinv(@playerThatRanCmd, @slotHighlighted)[type]; # Grab the ID of the item in the players hand
			
			if(array_contains(@allowedBooks, @itemInHand)){
			
				@itemMeta =  get_itemmeta(@slotHighlighted); # Grab the meta data
				msg(@itemMeta)			
				pgive_item(@playerToSendTo @itemInHand, 1, @itemMeta); # Create the copy and give it to the player
				
				die(); # All done				
			
			} else {
			
				msg('The Item you are Holding must be a Book'); # Scold the player for wasting time
				die(); # Finished
			
			}            
        
        }
    )
)

register_command(signbook, 

    array(   

        description: 'Re-signs a written book',        

        usage: '/signbook <signature>',
		
		permission: 'essentials.signbook',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {	
			
        
            if (array_size(@args) < 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /signbook <signature>');
                die(); # No need to go further					
            
            }
			
			@signature = ''; # Store the signature
			
			foreach(@lineOfText in @args){
			
				@signature = @signature.' '.@lineOfText; # Build the signature
			
			}
			
			@signature = trim(@signature); # Get rid of whitespace			

            @playerThatRanCmd = player(); # Create a player object
			
			@slotHighlighted = pheld_slot(@playerThatRanCmd)
			@itemInHand = pinv(@playerThatRanCmd, @slotHighlighted)[type]; # Grab the ID of the item in the players hand
			
			if(@itemInHand == 387){
			
				@itemMeta =  get_itemmeta(@slotHighlighted); # Grab the meta data
				@itemMeta[author] = @signature; # Sign the book with the new signature
				pgive_item(@playerThatRanCmd, 387, 1, @itemMeta); # Create new copy with new signature and give it to the player
				die(); # All done				
			
			} else {
			
				msg('You must be holding a signed written book'); # Scold the player for wasting time
				die(); # Finished
			
			}			

        }
    )
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

register_command(signature, 

	array(
	
		description: 'Generate a link to grab the players signature and value',
		
		usage: '/signature',		
	
		executor: closure(@alias, @sender, @args) {
		
			@arguements = ''; # String of arguements
	
			if (array_size(@args) == 0) {
			
				@player = player(); # Create a player object
				@playersUUID = puuid(@player); # Store the players UUID
				msg('Your Signature Link is: https://sessionserver.mojang.com/session/minecraft/profile/'.@playersUUID.'?unsigned=false');
				die(); # Done
			
			} else {
				
				try {
				
					@player = player(@args[0]); # Create a player object
					@playersUUID = puuid(@player); # Store the players UUID
					
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

register_command(warp_announce, 

	array(
		
		description: 'Announce where a player is warping to',
        
        usage: '/warp_announce <player> <warp>',
        
        permission: 'essentials.warpannounce',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
	
		executor: closure(@alias, @sender, @args) {		
	
			if (array_size(@args) != 2) {
			
				msg(''.color(RED).color(BOLD).'Improper Usage!');
				msg(''.color(RED).'Usage: /warp_announce <player> <warp>');
				die(); # No need to go further
			
			}
		
			try {
			
				@targetPlayer = player(@args[0]); # Grab the players name to announce
				@warpName = @args[1]; # Grab the name of the warp
				
				broadcast(colorize(_rainbowText(@targetPlayer).' is heading to: '._rainbowText(@warpName))); # Announce
				broadcast(colorize('&a&o/warp '.@warpName.' to join them')); # Announce			
				runas(@targetPlayer, '/warp '.@warpName); # Warp the player
				die(); # Done
			
			} catch (PlayerOfflineException @ErrorInfo) {
			
				msg('Player is Offline'); # Feedback
				die(); # DOne
			
			}
			
		}
	)
)

register_command(uberslap, 

	array(
	
		description: 'Uber Slap a Player',
        
        usage: '/uberslap <player>',
        
        permission: 'essentials.uberslap',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
	
		executor: closure(@alias, @sender, @args) {		
	
			if (array_size(@args) != 1) {
			
				msg(''.color(RED).color(BOLD).'Improper Usage!');
				msg(''.color(RED).'Usage: /uberslap <player>');
				die(); # No need to go further				
			
			}
		
			@lastTimeRun = 0;
			
			broadcast(color(GOLD).color(BOLD).player().color(GOLD).' has Uber Slapped '.color(BOLD).@args[0]);
			
			for (@i = 0, @i < 150, @i++){
			
				@lastTimeRun += 50
				
				set_timeout(@lastTimeRun, closure(_uberSlap(player(), player(@args[0]))));	
			
			}	
			
		}
	)
)


# --------------------------------------------------------------------------
# Over-Ride Functions
# --------------------------------------------------------------------------

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

# Deop Hook
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

	@perpage = 20;
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
				
		try {
		
			@database = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/essentials_plus_plus.sqlite'); # Database connection
			@sql = query(@database, 'INSERT OR IGNORE INTO `protected_warps` (warp, world) VALUES(?, ?);',@args[1], @playersWorld); # Add if not exists
			@sql = query(@database, 'UPDATE `protected_warps` SET world = ? WHERE warp=?;',@playersWorld, @args[1]); # Update record if exists
			
		
		} catch (SQLException @ErrorInfo) {
		
			msg(@player, 'SQL Error Occurred. Unable to create protected warp. See console for details');
			console('Essentials Plus Plus SQL Error: '.@ErrorInfo);
			return(true); # Cancel the original function
		
		}
		
		runas(@player, '/setwarp '.@args[1]); # Re-run the command without the unlock arguement since we already have the warp saved
		
		return(true); # Tell the original function to cancel, we'll take it from here (it's being re-run anyways)
		
	} else {
	
		# Delete protected warp because player excecuted /setwarp without the locked flag so if it exists as a locked warp, unlock it
		try {
		
			@database = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/essentials_plus_plus.sqlite'); # Database connection
			@sql = query(@database, 'DELETE FROM `protected_warps` WHERE `warp` = ?;',@args[1]); # Delete the protected warp			
		
		} catch (SQLException @ErrorInfo) {			
				
				console('Essentials Plus Plus SQL Error: '.@ErrorInfo);
				return(true); # Cancel the original function
			
		}
	
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
	
	try {
		
			@database = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/essentials_plus_plus.sqlite'); # Database connection
			@sql = query(@database, 'DELETE FROM `protected_warps` WHERE `warp` = ?;',@args[1]); # Delete the protected warp			
		
	} catch (SQLException @ErrorInfo) {
		
			msg(@player, 'SQL Error Occurred. Unable to delete protected warp. See console for details');
			console('Essentials Plus Plus SQL Error: '.@ErrorInfo);
			return(true); # Cancel the original function
		
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
	
	if(!has_permission('essentials.warps.*') || !has_permission('essentials.warps.'@args[1])) {
	
		return(false); # Let the essentials function handle it. This player doesnt have permission to use this warp
	
	}
	

	try {
		
			@database = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/essentials_plus_plus.sqlite'); # Database connection
			@sql = query(@database, 'SELECT * FROM `protected_warps` WHERE `warp`=?;',@args[1]); # Check for the protected warp

			foreach(@result in @sql){
			
				if(@args[1] == @result[warp]){
				
					@permission = 'multiverse.access.'.@result[world]; # Permission required to access protected warp
					sudo('/pex user '.@player.' add '.@permission); # Give access to the world
					set_timeout(1500, closure(sudo('/pex user '.@player.' remove '.@permission))) # Remove access 1.5 seconds later
					
					return(false); # Tell the function to go ahead
				
				}
			
			}
		
	} catch (SQLException @ErrorInfo) {
		
			msg(@player, 'SQL Error Occurred. Unable to delete protected warp. See console for details');
			console('Essentials Plus Plus SQL Error: '.@ErrorInfo);
			return(true); # Cancel the original function
		
	}
	
	return(false); # Tell the function to go ahead
)

# Getpos Hook
proc(_getpos, @playerName, @command,

	@args = parse_args(@command); # Parse the arguements
	
	@playerThatRanCmd = player(@playerName); # Create player object
	@targetPlayer = @playerThatRanCmd; # Assume we just care about the player that ran the command for now

	if (array_size(@args) == 2) {	
		
		@targetPlayer = @args[1];
		
	} else if (array_size(@args) > 2) {
	
		msg(''.color(RED).color(BOLD).'Improper Usage!');
		msg(''.color(RED).'Usage: /getpos [player]');
		die(); # No need to go further	
	
	}
	
	@targetPlayersLocation = ploc(@targetPlayer);
	
	tmsg(@playerThatRanCmd, colorize('&3&n'.@targetPlayer.'\'s Location:'));
	tmsg(@playerThatRanCmd, ''); # Blank line
	tmsg(@playerThatRanCmd, colorize('&3World: &b&o'.@targetPlayersLocation[world]));
	tmsg(@playerThatRanCmd, colorize('&3X: &b&o'.integer(@targetPlayersLocation[x]).'&3&o, &3Y: &b&o'.integer(@targetPlayersLocation[y]).'&3&o, &3Z: &b&o'.integer(@targetPlayersLocation[z])));	
	tmsg(@playerThatRanCmd, colorize('&3Pitch: &b&o'.round(@targetPlayersLocation[pitch], 2).'&3&o, &3Yaw: &b&o'.round(@targetPlayersLocation[yaw], 2)));		
	
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

	if (@Event[prefix] == "/getpos") {	
		
	
		if (has_permission(@Event[player], 'essentials.getpos')) {
		
			_getpos(@Event[player], @Event[command]); # Puff Puff Pass			
			cancel() # Over-ride the pre-existing getpos code (eesentials)		
			
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

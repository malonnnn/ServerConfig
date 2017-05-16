# Commands in File
# =================

# /redstone_trigger <x> <y> <z> <timeToActivate> <timeToDeActivate> <world>
#	- Creates a timer that places a redstone block after the time in seconds provided and removes the block after the time in seconds provided for de-activation

# /points_point1
#	- Stores location your looking at in point1

# /points_point2
#	- Stores location your looking at in point2

# /points_point3
#	- Stores location your looking at in point3

# /points_distance
#	- Calculates the distance in blocks between point1 and point2

# /points_showpoints
#	- Displays all the points you have set (point1, point2, point3) using colored wool (red, green, blue)

# /points_clearpoints
#	- Clears all stored lcoations

# /commandblock_generic OR /commandblock_generic <command>
# 	- Creates a generic commandblock with the command if supplied along with the coordinates of the commandblock

# /commandblock_clone
#	- Creates a commandblock pre-filled with the minecraft clone command with point1, point2, and point3 pre-filled in

# /commandblock_fill
#	- Creates a commandblock pre-filled with the minecraft fill command using point1 and point2

# /commandblock_setblock OR /commandblock_setblock <TileName> <dataValue> <oldBlockHandling> <dataTag>
#	- Creates a commandblock pre-filled with the minecraft setblock command using point1 as the location and generic data or supplied data

# /commandblock_tp
#	- Creates a commandblock pre-filled with the minecraft tp @p[r=2] command using point1 as the location

# /commandblock_trigger OR /commandblock_trigger <timeToActivate> <timeToDeActivate> <world>
#	- Creates a commandblock pre-filled with the redstone_trigger command using point1 as the location and pre-filled with generic data or supplied data 


register_command(redstone_trigger, 

	array(
	
		description: 'Records a set of coordinates for use with other commands',
		
		usage: '/redstone_trigger <x> <y> <z> <timeToActivate> <timeToDeActivate> <world>',
		
		permission: 'perm.nuts_and_bolts',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',
	
		executor: closure(@alias, @sender, @args) {
		
				if (array_size(@args) != 6) {
				
					msg(''.color(RED).color(BOLD).'Improper Usage!');
					msg(''.color(RED).'Usage: /redstone_trigger <x> <y> <z> <timeToActivate> <timeToDeActivate> <world>');
					die(); # No need to go further					
				
				}
		
				try {
				
					@playerThatRanCmd = player(); # Store player that ran command
					
				} catch (PlayerOfflineException @ErrorInfo) {
				
					msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
					die(); # Stop the command
				
				} catch (NotFoundException @ErrorInfo) {
				
					msg('Error Running Command: Player Not Found'); # Just to be safe
					die(); # Stop the command					
				
				}			

				try {
				
					@locationToPlaceBlock = array(x: integer(@args[0]), y: integer(@args[1]), z: integer(@args[2]));
					@timeToActivate = integer(@args[3]) * 1000; # Convert from seconds to milleseconds
					@timeToDeActivate = integer(@args[4]) * 1000; # Convert from seconds to milleseconds
				
				} catch (CastException @ErrorInfo) {
				
					msg('Invalid Arguements Supplied!'); # Tell them what went wrong
					msg('Expected Integers. <x> <y> <z> <timeToActivate> <timeToDeActivate> must be Numbers'); # Tell them what went wrong
					die(); # Kill the script					
				
				}

				try {
				
					@worldName = string(@args[5]); # Grab world name
					world_info(@worldName); # Run a check on the world supplied. If the world doesn't exist an exception will be raised. Used to check if world is valid.
				
				} catch (CastException @ErrorInfo) {
				
					msg('Invalid Arguement Supplied!'); # Tell them what went wrong
					msg('Expected String. <world> must be a string'); # Tell them what went wrong
					die(); # Kill the script
					
				} catch (InvalidWorldException @ErrorInfo) {

					msg('Invalid World!'); # Tell them what went wrong
					die(); # Kill the script

				}
				
				try {
				
					msg ('Activating Trigger'); # Give some feedback
					
					# Place redstone block after activation time, then set a new taks to de-activate the circuit by replacing the redstone block with air
					set_timeout(@timeToActivate, closure() {							

							set_block_at(@locationToPlaceBlock[x], @locationToPlaceBlock[y], @locationToPlaceBlock[z], '152:0', @worldName);
							set_timeout(@timeToDeActivate, closure(set_block_at(@locationToPlaceBlock[x], @locationToPlaceBlock[y], @locationToPlaceBlock[z], '0:0', @worldName)));
					
						}
					)					
					
				} catch (CastException @ErrorInfo) {
				
					msg('Uh Oh! Something went wrong.. Unable to set_timeout task');
					die(); # Terminate script
				
				}
		
		}
	)
)

register_command(points_point1, 

	array(
	
		description: 'Records a set of coordinates for use with other commands',
		
		usage: '/points_point1',
		
		permission: 'perm.nuts_and_bolts',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',
	
		executor: closure() {
		
				try {
				
					@playerThatRanCmd = player(); # Store player that ran command
					@lookingAt = pcursor(@playerThatRanCmd); # Store the players location in x, y, z, world format
					
				} catch (PlayerOfflineException @ErrorInfo) {
				
					msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
					die(); # Stop the command
				
				} catch (NotFoundException @ErrorInfo) {
				
					msg('Error Running Command: Player Not Found'); # Just to be safe
					die(); # Stop the command					
				
				} catch (RangeException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Cannot Place Block (Target out of Range)'); # Just to be safe
					die(); # Stop the command
				
				}
				
				@lookingAt[y] += 1; # Raise Y location up 1 block so its not the block beneath the player, but the block where the player is standing
				
				@variable = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point1'; # Generate a unique variable so multiple admins won't interfere with each other
				
				
				try {
				
					set_block_at(@lookingAt, '35:14'); # Place wool at players location to mark point
					export(@variable, @lookingAt); # Store the location in the global register
					
				} catch (FormatException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Oops! Something wen\'t wrong. Perhaps you\'re looking too far.'); # Talk to the player
					die(); # Terminate script
				
				}
				
				tmsg(@playerThatRanCmd, color(YELLOW).color(BOLD).color(ITALIC).'Red Wool Placed to Mark Location (Point #1)'); # Talk to the player
		
		}
	)
)

register_command(points_point2, 

	array(
	
		description: 'Records a set of coordinates for use with other commands',
		
		usage: '/points_point2',
		
		permission: 'perm.nuts_and_bolts',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',
	
		executor: closure() {
		
				try {
				
					@playerThatRanCmd = player(); # Store player that ran command
					@lookingAt = pcursor(@playerThatRanCmd); # Store the players location in x, y, z, world format
					
				} catch (PlayerOfflineException @ErrorInfo) {
				
					msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
					die(); # Stop the command
				
				} catch (NotFoundException @ErrorInfo) {
				
					msg('Error Running Command: Player Not Found'); # Just to be safe
					die(); # Stop the command					
				
				} catch (RangeException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Cannot Place Block (Target out of Range)'); # Just to be safe
					die(); # Stop the command
				
				}		
				
				@lookingAt[y] += 1; # Raise Y location up 1 block so its not the block beneath the player, but the block where the player is standing
				
				@variable = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point2'; # Generate a unique variable so multiple admins won't interfere with each other
				
				try {
				
					set_block_at(@lookingAt, '35:5'); # Place wool at players location to mark point
					export(@variable, @lookingAt); # Store the location in the global register
					
				} catch (FormatException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Oops! Something wen\'t wrong. Perhaps you\'re looking too far.'); # Talk to the player
					die(); # Terminate script
				
				}
				
				tmsg(@playerThatRanCmd, color(YELLOW).color(BOLD).color(ITALIC).'Green Wool Placed to Mark Location (Point #2)'); # Talk to the player
		
		}
	)
)

register_command(points_point3, 

	array(
	
		description: 'Records a set of coordinates for use with other commands',
		
		usage: '/points_point3',
		
		permission: 'perm.nuts_and_bolts',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',
	
		executor: closure() {
		
				try {
				
					@playerThatRanCmd = player(); # Store player that ran command
					@lookingAt = pcursor(@playerThatRanCmd); # Store the players location in x, y, z, world format
					
				} catch (PlayerOfflineException @ErrorInfo) {
				
					msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
					die(); # Stop the command
				
				} catch (NotFoundException @ErrorInfo) {
				
					msg('Error Running Command: Player Not Found'); # Just to be safe
					die(); # Stop the command					
				
				} catch (RangeException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Cannot Place Block (Target out of Range)'); # Just to be safe
					die(); # Stop the command
				
				}		
				
				@lookingAt[y] += 1; # Raise Y location up 1 block so its not the block beneath the player, but the block where the player is standing
				
				@variable = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point3'; # Generate a unique variable so multiple admins won't interfere with each other
				
				try {
				
					set_block_at(@lookingAt, '35:11'); # Place wool at players location to mark point
					export(@variable, @lookingAt); # Store the location in the global register
					
				} catch (FormatException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Oops! Something wen\'t wrong. Perhaps you\'re looking too far.'); # Talk to the player
					die(); # Terminate script
				
				}
				
				tmsg(@playerThatRanCmd, color(YELLOW).color(BOLD).color(ITALIC).'Blue Wool Placed to Mark Location (Point #3)'); # Talk to the player
		
		}
	)
)

register_command(points_clearpoints, 

	array(
	
		description: 'Clears all the stored points',
		
		usage: '/points_clearpoints',
		
		permission: 'perm.nuts_and_bolts',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',
	
		executor: closure() {
		
				try {
				
					@playerThatRanCmd = player(); # Store player that ran command
					
				} catch (PlayerOfflineException @ErrorInfo) {
				
					msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
					die(); # Stop the command
				
				} catch (NotFoundException @ErrorInfo) {
				
					msg('Error Running Command: Player Not Found'); # Just to be safe
					die(); # Stop the command					
				
				}
				
				@variables = array(); # Create a new array of variable's
				
				array_push(@variables, 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point1', 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point2', 
							'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point3');
				
				foreach(@variable in @variables) {				
					
					export(@variable, null); # Clear the variable in the global register
					
				}				
				
				tmsg(@playerThatRanCmd, color(AQUA).color(BOLD).color(ITALIC).'All Points Cleared..'); # Talk to the player
		
		}
	)
)

register_command(points_showpoints, 

	array(
	
		description: 'Show List of Points Recorded',
		
		usage: '/points_showpoints',
		
		permission: 'perm.nuts_and_bolts',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',
	
		executor: closure() {
		
				try {
				
					@playerThatRanCmd = player(); # Store player that ran command					
					
				} catch (PlayerOfflineException @ErrorInfo) {
				
					msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
					die(); # Stop the command
				
				} catch (NotFoundException @ErrorInfo) {
				
					msg('Error Running Command: Player Not Found'); # Just to be safe
					die(); # Stop the command					
				
				}			
				
				@variable1 = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point1'; # Generate variable to retrieve from global register. Uses players name
				@variable2 = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point2'; # Generate variable to retrieve from global register. Uses players name
				@variable3 = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point3'; # Generate variable to retrieve from global register. Uses players name
				
				@location1 = import(@variable1); # Retrieve the location from the global register
				@location2 = import(@variable2); # Retrieve the location from the global register				
				@location3 = import(@variable3); # Retrieve the location from the global register	

				if (@location1 == null && @location2 == null && @location3 == null) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).'No Points Set!');
					die(); # Stop command
				
				}
				
				if (@location1 != null){
	
					set_block_at(@location1, '35:14'); # Place red wool at location
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).'Red Wool Placed at Point #1');
		
				}
				
				if (@location2 != null){
	
					set_block_at(@location2, '35:5'); # Place green wool at location
					tmsg(@playerThatRanCmd, color(GREEN).color(BOLD).'Green Wool Placed at Point #2');
		
				}
				
				if (@location3 != null){
	
					set_block_at(@location3, '35:11'); # Place blue wool at location
					tmsg(@playerThatRanCmd, color(BLUE).color(BOLD).'Blue Wool Placed at Point #3');
		
				}
		
		}
	)
)

register_command(points_distance, 

	array(
	
		description: 'Show distanstace between points',
		
		usage: '/points_distance',

		permission: 'perm.nuts_and_bolts',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',		
	
		executor: closure() {
		
				try {
				
					@playerThatRanCmd = player(); # Store player that ran command					
					
				} catch (PlayerOfflineException @ErrorInfo) {
				
					msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
					die(); # Stop the command
				
				} catch (NotFoundException @ErrorInfo) {
				
					msg('Error Running Command: Player Not Found'); # Just to be safe
					die(); # Stop the command			
				}			
				
				@variable1 = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point1'; # Generate variable to retrieve from global register. Uses players name
				@variable2 = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point2'; # Generate variable to retrieve from global register. Uses players name
				
				@location1 = import(@variable1); # Retrieve the location from the global register
				@location2 = import(@variable2); # Retrieve the location from the global register						

				if (@location1 == null || @location2 == null) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).'You need to set 2 points first!');
					tmsg(@playerThatRanCmd, color(RED).color(ITALIC).'Do: points_point1 and points_point2');
					
					die(); # Stop command
				
				}
				
				# Lets fix the x, y, z and drop the decimal, We don't need to do floating point calculations
				@location1[x] = integer(@location1[x]);
				@location1[y] = integer(@location1[y]);
				@location1[z] = integer(@location1[z]);
				
				@location2[x] = integer(@location2[x]);
				@location2[y] = integer(@location2[y]);
				@location2[z] = integer(@location2[z]);	
				
				@calculationArray = array(0,0,0);
				
				if (@location1[x] != @location2[x]) {
					
					# If the two points aren't the same then let's find the difference
					
					if (@location1[x] > @location2[x]) {
					
						@calculationArray[0] = @location1[x] - @location2[x] # Figure out the difference
					
					} else {
					
						@calculationArray[0] = @location2[x] - @location1[x] # Figure out the difference
					
					}
					
				
				}
				
				if (@location1[y] != @location2[y]) {
					
					# If the two points aren't the same then let's find the difference
					
					if (@location1[y] > @location2[y]) {
					
						@calculationArray[1] = @location1[y] - @location2[y] # Figure out the difference
					
					} else {
					
						@calculationArray[1] = @location2[y] - @location1[y] # Figure out the difference
					
					}
					
				
				}
				
				if (@location1[z] != @location2[z]) {
					
					# If the two points aren't the same then let's find the difference
					
					if (@location1[z] > @location2[z]) {
					
						@calculationArray[2] = @location1[z] - @location2[z] # Figure out the difference
					
					} else {
					
						@calculationArray[2] = @location2[z] - @location1[z] # Figure out the difference
					
					}
					
				
				}
				
				@distance = 0; # Start with a distance of zero
				@distance += @calculationArray[0]; # Add values
				@distance += @calculationArray[1]; # Add values
				@distance += @calculationArray[2]; # Add values
				
				tmsg(@playerThatRanCmd, color(DARK_BLUE).'Point2 is '.color(DARK_AQUA).color(BOLD).@distance'Blocks'.color(DARK_BLUE).' away from Point1');			
		
		}
	)
)

register_command(commandblock_generic, 

	array(
	
		description: 'Places a commandblock with the players coordinates stored in the command for easy customizing.',
		
		usage: '/commandblock_generic OR /commandblock_generic <command>',
		
		permission: 'perm.nuts_and_bolts',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',
	
		executor: closure(@alias, @sender, @args) {
		
				@arguements = ''; # String of arguements
		
				if (array_size(@args) >= 1) {
				
					foreach(@arg in @args) {
					
						@arguements = @arguements.' '.@arg # Build the arguements string
				
					}					
				
				}
				
				@arguements = trim(@arguements); # Clear the white space at front and back
		
				try {
				
					@playerThatRanCmd = player(); # Store player that ran command
					@lookingAt = pcursor(@playerThatRanCmd); # Store the players location in x, y, z, world format
					
				} catch (PlayerOfflineException @ErrorInfo) {
				
					msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
					die(); # Stop the command
				
				} catch (NotFoundException @ErrorInfo) {
				
					msg('Error Running Command: Player Not Found'); # Just to be safe
					die(); # Stop the command					
				
				} catch (RangeException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Cannot Place Block (Target out of Range)'); # Just to be safe
					die(); # Stop the command
				
				}
				
				@lookingAt[y] += 1; # Raise Y location up 1 block so its not the block beneath the player, but the block where the player is standing
	
				@command = ''.integer(@lookingAt[x]).' '.integer(@lookingAt[y]).' '.integer(@lookingAt[z]).' '.@arguements; # Generate command with stored coordinates
	
				try {
				
					set_block_at(@lookingAt, '137'); # Place command block at players location
					set_block_command(@lookingAt, @command); # Set the command block command to the command we generated
					
				} catch (FormatException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Oops! Something wen\'t wrong. Unable to place block.'); # Talk to the player
					die(); # Terminate script
				
				}
				
				tmsg(@playerThatRanCmd, color(AQUA).color(BOLD).color(ITALIC).'Command Block Placed'); # Talk to the player
		
		}
	)
)

register_command(commandblock_trigger, 

	array(
	
		description: 'Places a commandblock with the trigger command pre-set using coordinates previously stored. Requires 1 point.',
		
		usage: '/commandblock_trigger OR /commandblock_trigger <timeToActivate> <timeToDeActivate> <world>',
		
		permission: 'perm.nuts_and_bolts',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',
	
		executor: closure(@alias, @sender, @args) {
		
				@arguements = ''; # String of arguements
		
				if (array_size(@args) >= 3) {
				
					@arguements = @args[0].' '.@args[1].' '.@args[2]; # Build arguements					
				
				}
		
				try {
				
					@playerThatRanCmd = player(); # Store player that ran command
					@lookingAt = pcursor(@playerThatRanCmd); # Store the players location in x, y, z, world format
					
				} catch (PlayerOfflineException @ErrorInfo) {
				
					msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
					die(); # Stop the command
				
				} catch (NotFoundException @ErrorInfo) {
				
					msg('Error Running Command: Player Not Found'); # Just to be safe
					die(); # Stop the command					
				
				} catch (RangeException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Cannot Place Block (Target out of Range)'); # Just to be safe
					die(); # Stop the command
				
				}	
				
				@lookingAt[y] += 1; # Raise Y location up 1 block so its not the block beneath the player, but the block where the player is standing
				
				@variable = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point1'; # Generate variable to retrieve from global register. Uses players name
				
				@location = import(@variable); # Retrieve the location from the global register
				
				if (@location == null){
	
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).'Point #1 not Set!');
					tmsg(@playerThatRanCmd, color(RED).color(ITALIC).'Do: /commandblock_point1 to record a location that is used by this command');
					die(); # Not enough info to set a command block so exit
		
				}
				
				if (length(@arguements) > 1){
				
					# Generate command with arguements
					@command = 'redstone_trigger '.integer(@location[x]).' '.integer(@location[y]).' '.integer(@location[z]).' '.
					@arguements; # Generate command with stored coordinates
				
				} else {
				
					# Generate command with generic arguements
					@command = 'redstone_trigger '.integer(@location[x]).' '.integer(@location[y]).' '.integer(@location[z]).' '.
					'<timeToActivate> <timeToDeActivate> <world>'; # Generate command with stored coordinates
				
				}
				
				try {
				
					set_block_at(@lookingAt, '137'); # Place command block at players location
					set_block_command(@lookingAt, @command); # Set the command block command to the command we generated
					
				} catch (FormatException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Oops! Something wen\'t wrong. Perhaps you\'re looking too far.'); # Talk to the player
					die(); # Terminate script
				
				}	
				
				tmsg(@playerThatRanCmd, color(AQUA).color(BOLD).color(ITALIC).'Command Block Placed'); # Talk to the player
		
		}
	)
)

register_command(commandblock_setblock, 

	array(
	
		description: 'Places a commandblock with the setblock command pre-set using coordinates previously stored. Requires 1 point.',
		
		usage: '/commandblock_setblock OR /commandblock_setblock <TileName> [dataValue] [oldBlockHandling] [dataTag]',
		
		permission: 'perm.nuts_and_bolts',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',
	
		executor: closure(@alias, @sender, @args) {
		
				@arguements = ''; # String of arguements
		
				if (array_size(@args) >= 4) {
				
					@arguements = @args[0].' '.@args[1].' '.@args[2].' '.@args[3]; # Build arguements					
				
				}
		
				try {
				
					@playerThatRanCmd = player(); # Store player that ran command
					@lookingAt = pcursor(@playerThatRanCmd); # Store the players location in x, y, z, world format
					
				} catch (PlayerOfflineException @ErrorInfo) {
				
					msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
					die(); # Stop the command
				
				} catch (NotFoundException @ErrorInfo) {
				
					msg('Error Running Command: Player Not Found'); # Just to be safe
					die(); # Stop the command					
				
				} catch (RangeException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Cannot Place Block (Target out of Range)'); # Just to be safe
					die(); # Stop the command
				
				}	
				
				@lookingAt[y] += 1; # Raise Y location up 1 block so its not the block beneath the player, but the block where the player is standing
				
				@variable = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point1'; # Generate variable to retrieve from global register. Uses players name
				
				@location = import(@variable); # Retrieve the location from the global register
				
				if (@location == null){
	
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).'Point #1 not Set!');
					tmsg(@playerThatRanCmd, color(RED).color(ITALIC).'Do: /commandblock_point1 to record a location that is used by this command');
					die(); # Not enough info to set a command block so exit
		
				}
				
				if (length(@arguements) > 1){
				
					# Generate command with arguements
					@command = 'setblock '.integer(@location[x]).' '.integer(@location[y]).' '.integer(@location[z]).' '.
					@arguements; # Generate command with stored coordinates
				
				} else {
				
					# Generate command with generic arguements
					@command = 'setblock '.integer(@location[x]).' '.integer(@location[y]).' '.integer(@location[z]).' '.
					'<TileName> [dataValue] [oldBlockHandling] [dataTag]'; # Generate command with stored coordinates
				
				}
				
				
				try {
				
					set_block_at(@lookingAt, '137'); # Place command block at players location
					set_block_command(@lookingAt, @command); # Set the command block command to the command we generated
					
				} catch (FormatException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Oops! Something wen\'t wrong. Perhaps you\'re looking too far.'); # Talk to the player
					die(); # Terminate script
				
				}	
				
				tmsg(@playerThatRanCmd, color(AQUA).color(BOLD).color(ITALIC).'Command Block Placed'); # Talk to the player
		
		}
	)
)

register_command(commandblock_tp, 

	array(
	
		description: 'Places a commandblock with the tp command pre-set using coordinates previously stored. Requires 1 point.',
		
		usage: '/commandblock_tp',
		
		permission: 'perm.nuts_and_bolts',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',
	
		executor: closure() {
		
				try {
				
					@playerThatRanCmd = player(); # Store player that ran command
					@lookingAt = pcursor(@playerThatRanCmd); # Store the players location in x, y, z, world format
					
				} catch (PlayerOfflineException @ErrorInfo) {
				
					msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
					die(); # Stop the command
				
				} catch (NotFoundException @ErrorInfo) {
				
					msg('Error Running Command: Player Not Found'); # Just to be safe
					die(); # Stop the command					
				
				} catch (RangeException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Cannot Place Block (Target out of Range)'); # Just to be safe
					die(); # Stop the command
				
				}		
				
				@lookingAt[y] += 1; # Raise Y location up 1 block so its not the block beneath the player, but the block where the player is standing
				
				@variable = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point1'; # Generate variable to retrieve from global register. Uses players name
				
				@location = import(@variable); # Retrieve the location from the global register
				
				if (@location == null){
	
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).'Point #1 not Set!');
					tmsg(@playerThatRanCmd, color(RED).color(ITALIC).'Do: /commandblock_point1 to record a location that is used by this command');
					die(); # Not enough info to set a command block so exit
		
				}

				@command = 'tp @p[r=2] '.integer(@location[x]).' '.integer(@location[y]).' '.integer(@location[z]); # Generate command with stored coordinates
	
				try {
				
					set_block_at(@lookingAt, '137'); # Place command block at players location
					set_block_command(@lookingAt, @command); # Set the command block command to the command we generated
					
				} catch (FormatException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Oops! Something wen\'t wrong. Perhaps you\'re looking too far.'); # Talk to the player
					die(); # Terminate script
				
				}	
				
				tmsg(@playerThatRanCmd, color(AQUA).color(BOLD).color(ITALIC).'Command Block Placed'); # Talk to the player
		
		}
	)
)

register_command(commandblock_fill, 

	array(
	
		description: 'Places a commandblock with the fill command pre-set using coordinates previously stored. Requires 2 points.',
		
		usage: '/commandblock_fill',
		
		permission: 'perm.nuts_and_bolts',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',
	
		executor: closure() {
		
				try {
				
					@playerThatRanCmd = player(); # Store player that ran command
					@lookingAt = pcursor(@playerThatRanCmd); # Store the players location in x, y, z, world format
					
				} catch (PlayerOfflineException @ErrorInfo) {
				
					msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
					die(); # Stop the command
				
				} catch (NotFoundException @ErrorInfo) {
				
					msg('Error Running Command: Player Not Found'); # Just to be safe
					die(); # Stop the command					
				
				} catch (RangeException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Cannot Place Block (Target out of Range)'); # Just to be safe
					die(); # Stop the command
				
				}		
				
				@lookingAt[y] += 1; # Raise Y location up 1 block so its not the block beneath the player, but the block where the player is standing
				
				@variable1 = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point1'; # Generate variable to retrieve from global register. Uses players name
				@variable2 = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point2'; # Generate variable to retrieve from global register. Uses players name
				@variable3 = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point3'; # Generate variable to retrieve from global register. Uses players name
				
				@location1 = import(@variable1); # Retrieve the location from the global register
				@location2 = import(@variable2); # Retrieve the location from the global register				
				@location3 = import(@variable3); # Retrieve the location from the global register				
				
				if (@location1 == null){
	
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).'Point #1 not Set!');
					tmsg(@playerThatRanCmd, color(RED).color(ITALIC).'Do: /commandblock_point1 to record a location that is used by this command');
					die(); # Not enough info to set a command block so exit
		
				}
				
				if (@location2 == null){
	
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).'Point #2 not Set!');
					tmsg(@playerThatRanCmd, color(RED).color(ITALIC).'Do: /commandblock_point2 to record a location that is used by this command');
					die(); # Not enough info to set a command block so exit
		
				}
				
				if (@location3 == null){
	
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).'Point #3 not Set!');
					tmsg(@playerThatRanCmd, color(RED).color(ITALIC).'Do: /commandblock_point3 to record a location that is used by this command');
					die(); # Not enough info to set a command block so exit
		
				}
				

				@command = 'fill '.integer(@location1[x]).' '.integer(@location1[y]).' '.integer(@location1[z]).' '.
							integer(@location2[x]).' '.integer(@location2[y]).' '.integer(@location2[z]).' '.
							'<TileName> [dataValue] replace <NewTileName> [NewDataValue]'; # Generate command with 2 x stored coordinates
	
				try {
				
					set_block_at(@lookingAt, '137'); # Place command block at players location
					set_block_command(@lookingAt, @command); # Set the command block command to the command we generated
					
				} catch (FormatException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Oops! Something wen\'t wrong. Perhaps you\'re looking too far.'); # Talk to the player
					die(); # Terminate script
				
				}	
				
				tmsg(@playerThatRanCmd, color(AQUA).color(BOLD).color(ITALIC).'Command Block Placed'); # Talk to the player
		
		}
	)
)

register_command(commandblock_clone, 

	array(
	
		description: 'Places a commandblock with the fill command pre-set using coordinates previously stored. Requires 3 points',
		
		usage: '/commandblock_clone',
		
		permission: 'perm.nuts_and_bolts',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',
	
		executor: closure() {
		
				try {
				
					@playerThatRanCmd = player(); # Store player that ran command
					@lookingAt = pcursor(@playerThatRanCmd); # Store the players location in x, y, z, world format
					
				} catch (PlayerOfflineException @ErrorInfo) {
				
					msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
					die(); # Stop the command
				
				} catch (NotFoundException @ErrorInfo) {
				
					msg('Error Running Command: Player Not Found'); # Just to be safe
					die(); # Stop the command					
				
				} catch (RangeException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Cannot Place Block (Target out of Range)'); # Just to be safe
					die(); # Stop the command
				
				}		
				
				@lookingAt[y] += 1; # Raise Y location up 1 block so its not the block beneath the player, but the block where the player is standing
				
				@variable1 = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point1'; # Generate variable to retrieve from global register. Uses players name
				@variable2 = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point2'; # Generate variable to retrieve from global register. Uses players name
				@variable3 = 'nuts_and_bolts.'.@playerThatRanCmd.'.cb_point3'; # Generate variable to retrieve from global register. Uses players name
				
				@location1 = import(@variable1); # Retrieve the location from the global register
				@location2 = import(@variable2); # Retrieve the location from the global register				
				@location3 = import(@variable3); # Retrieve the location from the global register				
				
				if (@location1 == null){
	
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).'Point #1 not Set!');
					tmsg(@playerThatRanCmd, color(RED).color(ITALIC).'Do: /commandblock_point1 to record a location that is used by this command');
					die(); # Not enough info to set a command block so exit
		
				}
				
				if (@location2 == null){
	
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).'Point #2 not Set!');
					tmsg(@playerThatRanCmd, color(RED).color(ITALIC).'Do: /commandblock_point2 to record a location that is used by this command');
					die(); # Not enough info to set a command block so exit
		
				}
				
				if (@location3 == null){
	
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).'Point #3 not Set!');
					tmsg(@playerThatRanCmd, color(RED).color(ITALIC).'Do: /commandblock_point3 to record a location that is used by this command');
					die(); # Not enough info to set a command block so exit
		
				}

				@command = 'clone '.integer(@location1[x]).' '.integer(@location1[y]).' '.integer(@location1[z]).' '.
							integer(@location2[x]).' '.integer(@location2[y]).' '.integer(@location2[z]).' '.
							integer(@location3[x]).' '.integer(@location3[y]).' '.integer(@location3[z]).' '.
							'[maskMode] [cloneMode] [TileName]'; # Generate command with 2 x stored coordinates
	
				try {
				
					set_block_at(@lookingAt, '137'); # Place command block at players location
					set_block_command(@lookingAt, @command); # Set the command block command to the command we generated
					
				} catch (FormatException @ErrorInfo) {
				
					tmsg(@playerThatRanCmd, color(RED).color(BOLD).color(ITALIC).'Oops! Something wen\'t wrong. Perhaps you\'re looking too far.'); # Talk to the player
					die(); # Terminate script
				
				}	
				
				tmsg(@playerThatRanCmd, color(AQUA).color(BOLD).color(ITALIC).'Command Block Placed'); # Talk to the player
		
		}
	)
)

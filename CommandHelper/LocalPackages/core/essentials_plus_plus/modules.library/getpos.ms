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

bind(player_command, null, array(prefix: '/getpos'), @Event,

	if (has_permission(@Event[player], 'essentials.getpos')) {
	
		_getpos(@Event[player], @Event[command]); # Puff Puff Pass			
		cancel() # Over-ride the pre-existing getpos code (eesentials)		
		
	}
	
)
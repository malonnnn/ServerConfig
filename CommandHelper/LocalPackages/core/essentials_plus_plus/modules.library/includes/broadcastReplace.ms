# --------------------------------------------------------------------------
# Fix Broadcast (Which will attempt to broadcast to fake players)
# --------------------------------------------------------------------------

proc('_broadcast', @msg, 

    @players = all_players(); # All players

    foreach(@player in @players) {
	
        tmsg(@player, colorize(@msg));
		
    }

)
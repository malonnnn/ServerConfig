# --------------------------------------------------------------------------
# Modules
# --------------------------------------------------------------------------

include('modules.library/afk.ms');
include('modules.library/books.ms');
include('modules.library/getpos.ms');
include('modules.library/help.ms');
include('modules.library/reop.ms');
include('modules.library/signature.ms');
include('modules.library/uberSlap.ms');
include('modules.library/uuid.ms');
include('modules.library/warpAnnounce.ms');
include('modules.library/warps.ms');
include('modules.library/warpAnnounce.ms');

# --------------------------------------------------------------------------
# Command Over-Rides
# --------------------------------------------------------------------------

bind(player_command, null, null, @Event, 	
    
    # DISABLED COMMANDS ---------------------------
    
    @disabledCmds = array('/jail', '/deljail', '/togglejail', '/setjail', '/jails');
    
    foreach(@command in @disabledCmds){
    
        if (@Event[prefix] == @command) {
        
            msg(color(RED).'That command has been disabled and is not in use on this server.'); # Tell the player
            cancel(); # Cancel the command since its in the disabled list
        
        }
    
    }	
    
)





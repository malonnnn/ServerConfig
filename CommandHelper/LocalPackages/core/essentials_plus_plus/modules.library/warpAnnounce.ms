# --------------------------------------------------------------------------
# Announce when a player uses a warp in colorful letters
# --------------------------------------------------------------------------

include('includes/rainbowTxt.ms');
include('includes/broadcastReplace.ms');

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
                
                _broadcast(_rainbowText(@targetPlayer).' is heading to: '._rainbowText(@warpName)); # Announce
                _broadcast('&a&o/warp '.@warpName.' to join them'); # Announce			
                runas(@targetPlayer, '/warp '.@warpName); # Warp the player
                die(); # Done
            
            } catch (PlayerOfflineException @ErrorInfo) {
            
                msg('Player is Offline'); # Feedback
                die(); # DOne
            
            }
            
        }
    )
)
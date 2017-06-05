# --------------------------------------------------------------------------
# Slaps a player around multiple times and plays a smacking sound
# --------------------------------------------------------------------------

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
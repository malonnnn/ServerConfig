register_command(hiresecretary, 

    array(
        description: 'Hire\'s a Player as a Secretary',
        usage: '/hiresecretary <player>',
        permission: 'hire.secretary',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /hiresecretary <player>');
                    die(); # No need to go further					
                
                }
                
                try {
                
                    @player = player(@args[0])
                    runas(~console,"/pex user ".@player." add is.secretary")
                    runas(~console,"/pex user ".@player." group add secretary")
                    tmsg(player(),color(red)."You have hired ".@player. " as secretary!")
                    tmsg(@player,color(red)."You have been hired as secretary")
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }		
                
                
        
        }
    )
)

register_command(firesecretary, 

    array(
        description: 'Fire\'s a Player as a Secretary',
        usage: '/firesecretary <player>',
        permission: 'fire.secretary',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /firesecretary <player>');
                    die(); # No need to go further					
                
                }
                
                try {
                
                    @player = player(@args[0])
                    
                    if(has_permission(@player,"is.secretary")){
                        runas(~console,"/pex user ".@player." remove is.secretary")
                        runas(~console,"/pex user ".@player." group remove secretary")
                        runas(~console,"/warp city ".@player)
                        tmsg(player(),color(red)."You have fired ". @player ." from secretary!")
                        tmsg(@player,color(red)."You have been fired from secretary!")
                    }
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }				
                
                
        
        }
    )
)

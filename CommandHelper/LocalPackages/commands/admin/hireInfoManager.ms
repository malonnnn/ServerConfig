register_command(hireinfomanager, 

    array(
        description: 'Hire\'s a Player as Info Manager',
        usage: '/hireinfomanager <player>',
        permission: 'hire.infomanager',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /hireinfomanager <player>');
                    die(); # No need to go further					
                
                }
                
                try {
                
                    @player = player(@args[0])
                    runas(~console,"/pex user ".@player." add is.infomanager")
                    runas(~console,"/pex user ".@player." group add infomanager")
                    tmsg(player(),color(red)."You have hired ".@player. " as Info Manager!")
                    tmsg(@player,color(red)."You have been hired as Info Manager")
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }		
                
                
        
        }
    )
)

register_command(fireinfomanager, 

    array(
        description: 'Fire\'s a Player as a Info Manager',
        usage: '/fireinfomanager <player>',
        permission: 'fire.infomanager',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /fireinfomanager <player>');
                    die(); # No need to go further					
                
                }
                
                try {
                
                    @player = player(@args[0])
                    
                    if(has_permission(@player,"is.infomanager")){
                        runas(~console,"/pex user ".@player." remove is.infomanager")
                        runas(~console,"/pex user ".@player." group remove infomanager")
                        runas(~console,"/warp city ".@player)
                        tmsg(player(),color(red)."You have fired ". @player ." from Info Manager!")
                        tmsg(@player,color(red)."You have been fired from Info Manager")
                    }
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }				
                
                
        
        }
    )
)

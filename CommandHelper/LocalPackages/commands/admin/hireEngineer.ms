register_command(hirednaengineer, 

    array(
        description: 'Hire\'s a Player as a DNA Engineer',
        usage: '/hirednaengineer <player>',
        permission: 'hire.dnaengineer',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /hirednaengineer <player>');
                    die(); # No need to go further					
                
                }
                
                try {
                
                    @player = player(@args[0])
                    runas(~console,"/pex user ".@player." add is.dnaengineer")
                    runas(~console,"/pex user ".@player." group add dnaengineer")
                    tmsg(player(),color(red)."You have hired ".@player. " as a DNA Engineer!")
                    tmsg(@player,color(red)."You have been hired as a DNA Engineer")
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }		
                
                
        
        }
    )
)

register_command(firednaengineer, 

    array(
        description: 'Fire\'s a Player as a DNA Engineer',
        usage: '/firednaengineer <player>',
        permission: 'fire.dnaengineer',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /firednaengineer <player>');
                    die(); # No need to go further					
                
                }
                
                try {
                
                    @player = player(@args[0])
                    
                    if(has_permission(@player,"is.dnaengineer")){
                        runas(~console,"/pex user ".@player." remove is.dnaengineer")
                        runas(~console,"/pex user ".@player." group remove dnaengineer")
                        runas(~console,"/warp city ".@player)
                        tmsg(player(),color(red)."You have fired ". @player ." from DNA Engineering!")
                        tmsg(@player,color(red)."You have been fired from DNA Engineering")
                    }
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }				
                
                
        
        }
    )
)

register_command(hireop, 

    array(
        description: 'Hire\'s a Player as a OP',
        usage: '/hireop <player>',
        permission: 'hire.op',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /hireop <player>');
                    die(); # No need to go further					
                
                }
                
                try {
                
                    @player = player(@args[0])
                    @puuid = puuid(@player,true)
                    runas(~console,"/pex group ".@puuid." create op")
                    runas(~console,"/pex group ".@puuid." prefix \"&4&lCo-Owner\"")
                    runas(~console,"/pex user ".@player." group set ".@puuid)
                    tmsg(player(),color(red)."You have hired ".@player. " as OP!")
                    tmsg(@player,color(red)."You have been hired as OP")
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }		
                
                
        
        }
    )
)

register_command(fireop, 

    array(
        description: 'Fire\'s a Player as OP',
        usage: '/fireop <player>',
        permission: 'fire.op',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /fireop <player>');
                    die(); # No need to go further					
                
                }
                
                try {
                
                    @player = player(@args[0])
                    @puuid = puuid(@player,true)
                    
                    runas(~console,"/pex user ".@player." group remove ".@puuid)
                    runas(~console,"/pex group ".@puuid." delete")
                    runas(~console,"/warp city ".@player)
                    tmsg(player(),color(red)."You have fired ". @player ." from OP!")
                    tmsg(@player,color(red)."You have been fired from OP!")
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }				
                
                
        
        }
    )
)

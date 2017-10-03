register_command('hirebuilder', 

    array(
        description: 'Hire\'s a Player as a builder',
        usage: '/hirebuilder <player>',
        permission: 'hire.builder',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {		
                cancel()
            }
            
            try {
            
                @player = player(@args[0])
                sudo("/pex user ".@player." group add builder")
                tmsg(player(),color(red)."You have hired ".@player." as a builder!")
                tmsg(@player,color(red)."You have been hired as a builder!")	
                
            } catch (PlayerOfflineException @ErrorInfo) {				
                msg('Player is Offline')
                die()
            }	 
        
        }
    )
)

register_command('firebuilder', 

    array(
        description: 'Fire\'s a Player as a builder',
        usage: '/firebuilder <player>',
        permission: 'fire.builder',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {		
                cancel()
            }
            
            try {
            
                @player = player(@args[0])
                sudo("/pex user ".@player." group remove builder")
                tmsg(player(),color(red)."You have fired ".@player." from builder!")
                tmsg(@player,color(red)."You have been fired from builder!")	
                
            } catch (PlayerOfflineException @ErrorInfo) {				
                msg('Player is Offline')
                die()
            }	 
        
        }
    )
)
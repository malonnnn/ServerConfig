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

register_command('givewe', 

    array(
        description: 'Give WorldEdit to a player',
        usage: '/givewe <player>',
        permission: 'give.we',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {		
                cancel()
            }
            
            try {
            
                @player = player(@args[0])
                sudo("/pex user ".@player." add worldedit.* vigilance_ruined_plots")
                sudo("/pex user ".@player." add essentials.skull vigilance_ruined_plots")
                sudo("/pex user ".@player." add essentials.skull.* vigilance_ruined_plots")
                tmsg(player(),color(red)."You have given ".@player." WorldEdit!")
                tmsg(@player,color(red)."You have been given WorldEdit!")	
                
            } catch (PlayerOfflineException @ErrorInfo) {				
                msg('Player is Offline')
                die()
            }	 
        
        }
    )
)

register_command('takewe', 

    array(
        description: 'Take WorldEdit from a player',
        usage: '/takewe <player>',
        permission: 'take.we',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                cancel()
            }
            
            try {
            
                @player = player(@args[0])
                sudo("/pex user ".@player." remove worldedit.* vigilance_ruined_plots")
                sudo("/pex user ".@player." remove essentials.skull vigilance_ruined_plots")
                sudo("/pex user ".@player." remove essentials.skull.* vigilance_ruined_plots")
                tmsg(player(),color(red)."You have taken WorldEdit from ".@player)
                tmsg(@player,color(red)."You have had WorldEdit taken from you!")	
                
            } catch (PlayerOfflineException @ErrorInfo) {				
                msg('Player is Offline')
                die()
            }	 
        
        }
    )
)

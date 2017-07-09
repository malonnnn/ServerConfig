register_command('hireofficer', 

    array(
        description: 'Hire\'s a Player as a Server Police Officer',
        usage: '/hireofficer <player>',
        permission: 'hire.officer',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /hireofficer <player>');
                die(); # No need to go further					
            
            }
            
            try {
            
                @player = player(@args[0])
                sudo("/pex user ".@player." add is.officer")
                sudo("/pex user ".@player." group add officer")
                runas('~console', '/rg addmember -w policeoffice police '.@player)
                tmsg(player(),color(red)."You have hired ".@player." as on Officer for the Police Force!")
                tmsg(@player,color(red)."You have been hired as an Officer for the Police Force!")	
                
            } catch (PlayerOfflineException @ErrorInfo) {				
                msg('Player is Offline')
                die()
            }	 
        
        }
    )
)

register_command('fireofficer', 

    array(
        description: 'Fire\'s a Player as a Server Police Officer',
        usage: '/fireofficer <player>',
        permission: 'fire.officer',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /fireofficer <player>');
                die(); # No need to go further					
            
            }
            
            try {
            
                @player = player(@args[0])
                if(has_permission(@player,"is.officer")){
                    sudo("/pex user ".@player." remove is.officer")
                    sudo("/pex user ".@player." group remove officer")
                    runas('~console', '/rg removemember -w policeoffice police '.@player)
                    runas('~console', '/rg removemember -w policeoffice sergeants '.@player)
                    sudo("/minecraft:clear ".@player)
                    tmsg(player(),color(red)."You have fired ". @player ." from the Police Force.")
                    tmsg(@player,color(red)."You have been fired from the Police Force :(")
                }
                
            } catch (PlayerOfflineException @ErrorInfo) {				
                msg('Player is Offline')
                die()
            }	 
        
        }
    )
)

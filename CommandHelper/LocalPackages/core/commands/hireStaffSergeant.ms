register_command(hirestaffsergeant, 

    array(
    
        description: 'Hire\'s a Player as a Server Police Staff Sergeant',
        
        usage: '/hirestaffsergeant <player>',
        
        permission: 'ch.alias.hirestaffsergeant',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        tabcompleter: closure(@alias, @sender, @args) {
            try{
                if(array_size(@args) == 0) {
                    return(all_players());
                }
                @search = @args[array_size(@args) - 1];
                    return(array_filter(all_players(), closure(@index, @player) {
                    return(equals_ic(@search, substr(@player, 0, length(@search))));
                }));
            } catch (RangeException @ErrorInfo) {
                # Ignore
            }
        },
    
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /hirestaffsergeant <player>');
                die(); # No need to go further					
            
            }
            
            try {
            
                @player = player(@args[0])
                sudo("/pex user ".@player." add is.staffsergeant")
                sudo("/pex user ".@player." remove is.sergeant")
                sudo("/pex user ".@player." remove is.officer")				
                sudo("/pex user ".@player." add ch.alias.onduty")
				runas('~console', '/rg addmember -w policeoffice police '.@player)
				runas('~console', '/rg addmember -w policeoffice sergeants '.@player)
                tmsg(player(),color(red)."You have hired ".@player. " as a Staff Sergeant for the Police Force!")
                tmsg(@player,color(red)."You have been hired as a Staff Sergeant for the Police Force!")
                
            } catch (PlayerOfflineException @ErrorInfo) {				
                msg('Player is Offline')
                die()
            }
        
        }
    )
)

register_command(firestaffsergeant, 

    array(
    
        description: 'Fire\'s a Player as a Server Police Sergeant',
        
        usage: '/firestaffsergeant <player>',
        
        permission: 'ch.alias.firestaffsergeant',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        tabcompleter: closure(@alias, @sender, @args) {
            try{
                if(array_size(@args) == 0) {
                    return(all_players());
                }
                @search = @args[array_size(@args) - 1];
                    return(array_filter(all_players(), closure(@index, @player) {
                    return(equals_ic(@search, substr(@player, 0, length(@search))));
                }));
            } catch (RangeException @ErrorInfo) {
                # Ignore
            }
        },
    
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /firesergeant <player>');
                die(); # No need to go further					
            
            }
            
            try {
            
                @player = player(@args[0])
                if(has_permission(@player,"is.officer")){
                    sudo("/pex user ".@player." remove is.sergeant")
                    sudo("/pex user ".@player." remove is.staffsergeant")
                    sudo("/pex user ".@player." remove ch.alias.onduty")
                    sudo("/pex user ".@player." remove is.suspended")
                    sudo("/pex user ".@player." remove is.officer")
					runas('~console', '/rg removemember -w policeoffice police '.@player)
					runas('~console', '/rg removemember -w policeoffice sergeants '.@player)					
                    sudo("/pex user ".@player." group set mortal")
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

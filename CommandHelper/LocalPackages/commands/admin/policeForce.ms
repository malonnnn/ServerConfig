
register_command(suspendofficer, 

    array(
    
        description: 'Places an Officer under Suspension',
        
        usage: '/suspendofficer <player>',
        
        permission: 'ch.alias.suspendofficer',
        
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
                msg(''.color(RED).'Usage: /suspendofficer <player>');
                die(); # No need to go further					
            
            }
            
            try {
                @plr = player(@args[0])
                @player = player()
                
                sudo("/pex user ".@plr." add is.suspended")
                tmsg(@plr,color(red).'You have been suspended from your duties until further notice')
                tmsg(@player,color(red).'You have suspended '.@plr.' from his/her duties.')	
            } catch (PlayerOfflineException @ErrorInfo) {				
                msg(@player,'Player: '.@plr.' is Offline')
                die()
            }                         
        
        }
    )
)

register_command(reinstateofficer, 

    array(
    
        description: 'Remove an Officer\'s Suspension',
        
        usage: '/reinstateofficer <player>',
        
        permission: 'ch.alias.reinstateofficer',
        
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
                msg(''.color(RED).'Usage: /reinstateofficer <player>');
                die(); # No need to go further					
            
            }
            
            try {
                @plr = player(@args[0])
                @player = player()
                
                sudo("/pex user ".@plr." remove is.suspended")
                tmsg(@plr,color(red).'You have been restored to your full duties')
                tmsg(@player,color(red).'You removed '.@plr.'\'s suspension.')	
            } catch (PlayerOfflineException @ErrorInfo) {				
                msg(@player,'Player: '.@plr.' is Offline')
                die()
            }                         
        
        }
    )
)

set_timeout(3000, closure(

    @allPlayers = all_players()
    
    foreach(@player in @allPlayers){
    
        if(has_permission(@player, 'ch.alias.offduty') && !pisop(@player)){
        
            if (pworld(@player) != 'policeoffice') {
            
                tmsg(@player, color(RED).'You will be placed Off Duty Automatically in 2 Minutes')
                set_timeout(120000,closure(    
                    runas(@player,"/offduty")
                ))
            
            } else {

                bind(world_changed, null, array(player: @player), @event,				

                    if(@event['to'] != 'policeoffice') {
                    
                        if(!has_permission(@event[player], 'ch.alias.offduty')){
                            
                            unbind()
                            die()
                        
                        }
                    
                        tmsg(@event[player], color(RED).'You will be placed Off Duty Automatically in 2 Minutes')
                    
                        set_timeout(120000,closure(    
                            runas(player(@event[player]),"/offduty")
                        ))
                        
                        unbind()
                    
                    }				

                )
            }
        }
    }

))

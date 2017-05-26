register_command(onduty, 

    array(
    
        description: 'Used by Server Officer\'s to place themselves On Duty',
        
        usage: '/onduty',
        
        permission: 'ch.alias.onduty',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {			
                
            @player = player()
            @playersUUID = puuid(@player); # Store the players UUID which we use to identify them with variables stored in the register
            @playersGroup = pgroup(@player); # Store the players current group to be used with the offduty command 
    
            @keyPreviousGroup = 'police.'.@playersUUID.'.pgroup'; # Unique AFK key to store the previous
            export(@keyPreviousGroup, @playersGroup); # Store the previous group in the register				
            set_pmode(@player,'SURVIVAL')
            if(has_permission(@player,"is.sergeant")){
            
                set_timeout(3000,closure(
                    sudo("/pex user " . @player . " group set sergeant")
                    tmsg(@player,color(red)."You are now on duty!")
                ))
                
            }else if(has_permission(@player,'is.officer')){
                set_timeout(3000,closure(
                    sudo("/pex user " . @player . " group set officer")
                    tmsg(@player,color(red)."You are now on duty!")
                ))
                
            }else if(has_permission(@player,'is.policechief')){
                set_timeout(3000,closure(
                    sudo("/pex user " . @player . " group set policechief")
                    tmsg(@player,color(red)."You are now on duty!")
                ))
                
            }else if(has_permission(@player,'is.deputychief')){
                set_timeout(3000,closure(
                    sudo("/pex user " . @player . " group set deputychief")
                    tmsg(@player,color(red)."You are now on duty!")
                ))	
                
            }else{
                tmsg(@player,color(red)."You are not part of the Police Force!")
            }              
        
        }
    )
)

register_command(offduty, 

    array(
    
        description: 'Used by Server Officer\'s to place themselves Off Duty',
        
        usage: '/offduty',
        
        permission: 'ch.alias.offduty',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {			
                
            @player = player()
            @playersUUID = puuid(@player); # Store the players UUID which we use to identify them with variables stored in the register
            @playersGroup = pgroup(@player); # Store the players current group to be used with the offduty command 
    
            @keyPreviousGroup = 'police.'.@playersUUID.'.pgroup'; # Unique AFK key to store the previous
            @playersPreviousGroup = import(@keyPreviousGroup); # Retrieves the previous group in the register				
            
            if (@playersPreviousGroup == null) {
            
                msg('Unable to determine your previous Hero Class. You will be mortalled instead. Sorry.');	
                include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
                _mortal(@player)

                die(); # Done
            
            } else {
            
                @allPlayers = all_players(); # Grab a list of all players to check if someone else is using the Hero
                
                foreach (@plr in @allPlayers){
                
                    if(@playersPreviousGroup == pgroup(@plr)){
                    
                        msg('Sorry someone else is using the Hero you previously had. You will be mortalled instead.');
                        include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
                        _mortal(@player)
                        die(); # Done
                    
                    }
                
                
                }
                
                sudo("/pex user " . @player . " group set ".@playersPreviousGroup); # Set the player back to their previous hero
            
            }                
        
        }
    )
)

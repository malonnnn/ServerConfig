register_command(onduty, 

    array(
    
        description: 'Used by Server Officer\'s to place themselves On Duty',
        
        usage: '/onduty',
        
        permission: 'onduty',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {			
                
                @player = player()
                if(has_permission(@player,"is.sergeant")){
                    set_timeout(3000,closure(
                        sudo("/pex user " . @player . " group set sergeant")
                        tmsg(@player,color(red)."You are now on duty!")
                    ))

                    if(pworld(@player) != 'policeoffice' && !has_permission(@player,'police.chief')){
                        set_timeout(120000,closure(
                            include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
                            _mortal(@player)
                        ))
                    }
                }else if(has_permission(@player,'is.officer')){
                    set_timeout(3000,closure(
                        sudo("/pex user " . @player . " group set officer")
                        tmsg(@player,color(red)."You are now on duty!")
                    ))

                    if(pworld(@player) != 'policeoffice' && !has_permission(@player,'police.chief')){
                        set_timeout(120000,closure(
                            include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
                            _mortal(@player)
                        ))
                    }
                }else{
                    tmsg(@player,color(red)."You are not part of the Police Force!")
                }
        
                
        
        }
    )
)
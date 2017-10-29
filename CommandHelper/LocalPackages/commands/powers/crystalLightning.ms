register_command(crystallightning, 
    array(
        description: 'Power',
        permission: 'powers.crystallightning',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() { 

            @player = player()
            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('crystalLightning',1,@player)
    
            if(!has_bind(@player.'crystalLightning')){
                console('binded!')
                bind(entity_damage,array('id':@player.'crystalLightning'),array('cause':'LIGHTNING'),@e,@player){
                    if(@player == player()){
                        cancel()
                        unbind()
                    }
                }
            }
            set_timeout(500,closure( 
                lightning(ploc(@player))
            ))
        }
    
    )
) 

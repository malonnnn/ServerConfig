register_command(bodyslide, 

    array(
    
        description: 'Powerslide',
        
        permission: 'ch.alias.bodyslide',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {
        
            @player = player()
            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @class = _getheroclass(@player)
            
            @allPlayers = all_players()

            if(@class == "deadpool"){
                tmsg(@player,color(red).'Locating Cable...')
                set_timeout(2000,closure(
                    foreach(@plr in @allPlayers){
                        if(_getheroclass(@plr) == 'cable'){
                            tmsg(@player,color(red).'Cable Found! Locking on..')
                            set_timeout(1000,closure(
                                tmsg(@player,color(red).'Lock on successful! Teleporting...')
                                set_timeout(1000,closure(
                                    runas(~console,'/minecraft:tp '.@player.' '.@plr)
                                ))
                            ))
                        }else{
                            tmsg(@player,color(red).'Error! Cable not found!')
                            die()
                        }
                    }
                ))
            }else{
                tmsg(@player,color(red).'Locating Deadpool...')
                set_timeout(2000,closure(
                    foreach(@plr in @allPlayers){
                        if(_getheroclass(@plr) == 'deadpool'){
                            tmsg(@player,color(red).'Deadpool Found! Locking on..')
                            set_timeout(1000,closure(
                                tmsg(@player,color(red).'Lock on successful! Teleporting...')
                                set_timeout(1000,closure(
                                    runas(~console,'/minecraft:tp '.@player.' '.@plr)
                                ))
                            ))
                        }else{
                            tmsg(@player,color(red).'Error! Deadpool not found!')
                            die()
                        }
                    }
                ))
            }
            
        }
    )
)

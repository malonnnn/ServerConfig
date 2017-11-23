register_command(touchkill, 
    array(
        description: 'Power',
        permission: 'ch.alias.touchkill',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {        
        
            @player = player()

    
            @plrs = players_in_radius(ploc(),2)
    
            foreach(@plr in @plrs){

                @ploc = ploc(@plr) 
                if(has_permission(@plr, "kill.immune")){
                    tmsg(@player, color(red). "Sorry but you can't kill them because they are better than you.")
                    die()
                }
                if(sk_region_check_flag(@ploc,'invincible',@plr) == true){
                    tmsg(@player,color(red).'Sorry, they are protected from touchkill.')
                    die()
                }

                if(@plr != @player){
                    include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
                    _coolDown('touchkill',10,@player)
                    broadcast(player()." touched @plr and they died. R.I.P.")
                    pkill(@plr)
                    die()
                }
            }

            tmsg(player(),"You are not close enough to that person.")
                
        }
    )
)

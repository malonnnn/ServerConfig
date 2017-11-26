register_command(canarycry, 
    array(
        description: 'White Canary attack',
        permission: 'powers.canarycry',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {
        
            @player = player()
            @ploc = ploc(@player)
            @plrs = players_in_radius(@ploc,100)

            foreach(@plr in @plrs){
                if(@plr != @player){
                    damage_entity(puuid(@plr),3,puuid(@player))
                    tmsg(@plr,color(RED).'You have been damaged by Canary Cry!')
                }
            }
    
        }
    )
)

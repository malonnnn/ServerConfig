register_command(destroyworld, 
    array(
        description: 'Destroys the world',
        permission: 'powers.destroyworld',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {
        
            @plr = player()
            @world = pworld(@plr)
            @plrs = all_players(@world)
            @puuid = puuid(@plr)
            
            @ents = all_entities(@world)

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('destroyWorld',1800,@plr)

            foreach(@ent in @ents){
                if(is_entity_living(@ent) && @puuid != @ent){
                    set_entity_health(@ent,0)
                }
            }
            
            broadcast(@plr." ate ".@world." and killed everyone within it") 
                
        }
    )
)

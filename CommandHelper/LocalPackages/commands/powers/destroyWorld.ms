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
                    @plrName = get_player_from_entity_id(@ent)
                    if(@plrName != null && !has_permission(@plrName,'immune.destroyworld')){
                        set_entity_health(@ent,0)
                    }
                }
            }
            
            broadcast(color(DARK_RED).color(MAGIC)."!i".color(WHITE)." ".@plr." ".color(DARK_RED).color(UNDERLINE)."destroyed".color(GRAY).color(ITALICS)." ".@world.color(RED)." and its every living inhabitant.") 
                
        }
    )
)

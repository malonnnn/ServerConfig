bind(player_toggle_sneak,null,null,@event){
    @player = player()

    if(import(@player.'wallRunStatus') && has_permission(@player, "powers.wallrun")){
        include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
        @class = _getheroclass(@player)
        @eventID = associative_array('id': @player.'runwalls')
        @isSneaking = @event['sneaking']
        
        if(@isSneaking){
            include('/home/minecraft/server/plugins/CommandHelper/includes/wallRun.ms')
        
            @realID = bind(player_move, @eventID, associative_array('player': @player), @event,
            @player, @eventID, @isSneaking){
                
                _wallRun(@player)
               set_entity_fall_distance(puuid(),0.0) 
            }
            export(@eventID['id'],@realID)
        }else{
            unbind(import(@eventID['id']))
        }
    
    }
}


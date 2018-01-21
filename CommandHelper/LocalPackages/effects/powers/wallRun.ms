bind(player_toggle_sneak,null,null,@event){
    @player = @event['player']

    if(import(@player.'wallRunStatus') && has_permission(@player, "powers.wallrun")){
        @isSneaking = @event['sneaking']
        @eventID = associative_array('id': @player.'runwalls')
        if(@isSneaking){
            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @class = _getheroclass(@player)
            include('/home/minecraft/server/plugins/CommandHelper/includes/wallRun.ms')
        
            @realID = bind(player_move, @eventID, associative_array('player': @player), @event,
            @player, @eventID, @isSneaking, @puuid = puuid(@player)){
                
                _wallRun(@player)
               set_entity_fall_distance(@puuid,0.0) 
            }
            export(@eventID['id'],@realID)
        }else{
            unbind(import(@eventID['id']))
        }
    
    }
}


bind(player_toggle_sneak,null,null,@event){
    @player = player()
    @class = pgroup()[0]
    
    if(has_permission(@player, "powers.wallclimb")){
        @eventID = associative_array('id': @player.'climbwalls')
        @isSneaking = @event['sneaking']
        
        if(@isSneaking){
        
            include('/home/minecraft/server/plugins/CommandHelper/includes/wallClimb.ms')
            @blocksChanged = _spidermanVinePlacement(ploc(),"106",@player)
            export(@player."blocksChanged",@blocksChanged)
        
            @realID = bind(player_move, @eventID, associative_array('player': @player), @event,
            @player, @eventID, @isSneaking){
                
                @blocksChanged = import(@player."blocksChanged")
                foreach(@val in @blocksChanged){
                    psend_block_change(@val,"0:0")
                }

                @blocksChanged = _spidermanVinePlacement(ploc(),"106",@player)
                export(@player."blocksChanged",@blocksChanged)
            }
            export(@eventID['id'],@realID)
        }else{
            unbind(import(@eventID['id']))
            @blocksChanged = import(@player."blocksChanged")
            foreach(@val in @blocksChanged){
                psend_block_change(@val,"0:0")
            }
        }
    
    }
}
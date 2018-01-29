bind(food_level_changed,null,null,@event){
    @player = @event['player']
    if(has_permission(@player,'is.ingame')){
        modify_event('level',10)
    }
}

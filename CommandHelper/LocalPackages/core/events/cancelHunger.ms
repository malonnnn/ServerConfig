bind(food_level_changed,null,null,@event){
    @player = @event['player']
    if(!has_permission(@player,'needsto.eat')){
        modify_event('level',17)
    }
}

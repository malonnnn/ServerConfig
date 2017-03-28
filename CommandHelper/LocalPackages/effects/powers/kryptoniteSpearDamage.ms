bind(entity_damage_player,null,array('button': 'LEFT'),@event){

    if(@event['damager'] == 'PLAYER'){
        @attacker = @event['data']
        @victim = player()
        if(has_permission(@victim,'weakto.kryptonite')){
            @inv = pinv(@attacker,null)
            if(@inv == null){
                die()   
            }
            if(@inv['meta']['display'] == '§aKr§2y§apt§2o§anite §7Sp§8ea§7r'){
                modify_event('amount',200)
            }
        }
    }

}

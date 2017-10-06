bind(player_interact,null,array('button': 'LEFT'),@event){

    @player = player()
        
    if(!import(@player.'fireballPunchStatus') || !has_permission("powers.fireballpunch") || pinv(@player,null) != null){
        die()
    }

    include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
    _coolDown('fireBallPunch',2,@player)    
    
    @multiplier = 5
    @arrow = shoot_projectile(@player, 'FIREBALL')
    @velocity = entity_velocity(@arrow)
    set_entity_velocity(@arrow, array(@velocity['x'] * @multiplier, @velocity['y'] * @multiplier, @velocity['z'] * @multiplier))
}

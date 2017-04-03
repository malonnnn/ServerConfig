bind(player_interact,null,array('button': 'LEFT'),@event){

    @player = player()
        
    if(!has_permission("powers.fireballpunch" || pinv(null) != null)){
        die()
    }
    
    assign(@cooldown, 2)
    assign(@lastshot, import(@player.'lastshot'))
    if(@lastshot + @cooldown > time() / 1000,
        die()
    )
    export(@player.'lastshot', time() / 1000)
    
    @multiplier = 5
    @arrow = shoot_projectile(@pname, 'FIREBALL')
    @velocity = entity_velocity(@arrow)
    set_entity_velocity(@arrow, array(@velocity['x'] * @multiplier, @velocity['y'] * @multiplier, @velocity['z'] * @multiplier))
}
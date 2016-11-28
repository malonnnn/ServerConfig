bind(player_interact,null,array('button': 'LEFT'),@event){

    @pname = player()
    @pgroup = pgroup()
    @pworld = pworld()
    @puuid = puuid()
        
    if(!has_permission("powers.fireballpunch"))
    {
        die()
    }
    
    if(get_inventory(entity_id(@puuid),pheld_slot(@pname)) != null){
        die();
    }
    
    if(is_null(get_value('lastshot')),
        store_value('lastshot',0)
    )
    
    assign(@cooldown, 2)
    
    assign(@lastshot, get_value('lastshot'))
    if(@lastshot + @cooldown > time() / 1000,
        die()
    )
    store_value('lastshot', time() / 1000)
    
    
    cancel()
    @multiplier = 5
    @arrow = shoot_projectile(@pname, 'FIREBALL')
    @velocity = entity_velocity(@arrow)
    set_entity_velocity(@arrow, array(@velocity['x'] * @multiplier, @velocity['y'] * @multiplier, @velocity['z'] * @multiplier))
    die()
}
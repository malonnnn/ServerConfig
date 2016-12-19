bind(player_interact, null, array(item: 0, button: 'left'), @event,

    @player = player()
    
    if(has_permission(@player,'ch.alias.websling')){

        assign(@cooldown, 1)
      
        if(is_null(get_value(@player.'lastwebshot')),
            store_value(@player.'lastwebshot',0)
        )

        assign(@lastshot, get_value(@player.'lastwebshot'))
        if(@lastshot + @cooldown > time() / 1000,
            die()
        )
        store_value(@player.'lastwebshot', time() / 1000)
      
        @multiplier = 0.5
        @arrow = shoot_projectile(player(), 'ARROW')
        @velocity = entity_velocity(@arrow)
        
        # spawn pig
        @ploc = ploc()
        @ploc['y']  = @ploc['y'] + 1
        @pig = spawn_entity("CHICKEN", 1, @ploc)[0]
        
        try(set_mob_effect(@pig, 14, 1, 9999, true, false),
            tmsg(player(), "Sorry, you can't use websling in here")
            entity_remove(@arrow)
            die()
        )
        
        # set pig invisible
        set_mob_effect(@pig, 11, 254, 9999, true, false)
        
        # sit player on pig
        set_entity_rider(@pig, puuid(player(),true))
        
        set_leashholder(@pig,@arrow)
        
        set_entity_velocity(@arrow, array(@velocity['x'] * @multiplier, @velocity['y'] * @multiplier, @velocity['z'] * @multiplier))

        
        bind(projectile_hit, associative_array('id': 'webshot'.@arrow), null, @event, 
        @arrow, @pig, @player = player()) {
        
            set_timeout(5000, closure(){
                entity_remove(@pig)
                entity_remove(@arrow)
            });
            unbind()
        }
    }

)

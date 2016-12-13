bind(player_interact,null,array('button': 'LEFT'),@event){
    
    @pname = player()
    @pgroup = pgroup()
    @pworld = pworld()
    @puuid = puuid()
    
    if(!has_permission("powers.pointandclicklightning")){
        die()
    }
    
    if(get_inventory(entity_id(@puuid),pheld_slot(@pname)) != null){
        die();
    }
    
    if(is_null(get_value(@pname.'lastshot')),
        store_value(@pname.'lastshot',0)
    )
    
    assign(@cooldown, 2)
    
    assign(@lastshot, get_value(@pname.'lastshot'))
    if(@lastshot + @cooldown > time() / 1000,
        die()
    )
    store_value(@pname.'lastshot', time() / 1000)
    
    
    cancel()
    sudo(/lightning)
    die()
}

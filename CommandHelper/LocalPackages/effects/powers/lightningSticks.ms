bind(player_interact,null,array('item': 280,'button': 'LEFT'),@event){
    
    if(!has_permission("powers.lightningsticks"))
    {
        die()
    }
    
    @pname = player()
    @pgroup = pgroup()
    @pworld = pworld()
    @puuid = puuid()
    
    if(
        @pworld != '1_9' && 
        @pworld != 'greenfield' && 
        @pworld != 'destructiblecity'
    ){
        die()
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
    sudo(/lightning)
    die()
}
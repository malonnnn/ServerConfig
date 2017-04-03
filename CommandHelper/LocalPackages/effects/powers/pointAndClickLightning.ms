bind(player_interact,null,array('button': 'LEFT'),@event){
    
    @player = player()
    
    if(!has_permission("powers.pointandclicklightning") || pinv(@player,null) != null){
        die()
    }
    
    assign(@cooldown, 2)
    assign(@lastshot, import(@player.'lastshot'))
    if(@lastshot + @cooldown > time() / 1000,
        die()
    )
    export(@player.'lastshot', time() / 1000)
    
    sudo('/lightning')
}

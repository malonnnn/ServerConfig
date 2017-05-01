bind(player_interact,null,array('button': 'LEFT'),@event){
    
    @player = player()
    
    if(!has_permission("powers.pointandclicklightning") || pinv(@player,null) != null){
        die()
    }
    @ploc = ploc(@player) 
    if(sk_region_check_flag(@ploc,'invincible',@player) == true){
        tmsg(@player,color(red).'Sorry, you can\'t use lightning here.')
        die()
    }
    if(sk_region_check_flag(@ploc,'pvp',@player) == false){
        tmsg(@player,color(red).'Sorry, you can\'t use lightning here.')
        die()
    }
    
    assign(@cooldown, 2)
    assign(@lastshot, import(@player.'lastlightning'))
    if(@lastshot + @cooldown > time() / 1000,
        die()
    )
    export(@player.'lastshot', time() / 1000)
    
    sudo('/lightning')
}

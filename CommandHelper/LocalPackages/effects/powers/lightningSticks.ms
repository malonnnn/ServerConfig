bind(player_interact,null,array('item': 280,'button': 'LEFT'),@event){
    
    if(!has_permission("powers.lightningsticks")){
        die()
    }
    
    @player = player()

    assign(@cooldown, 2)
    assign(@lastshot, import(@player.'lastshot'))
    if(@lastshot + @cooldown > time() / 1000,
        die()
    )
    export(@player.'lastshot', time() / 1000)
    
    sudo('/lightning')
}
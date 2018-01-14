bind(player_interact,null,array('button': 'LEFT'),@event){
    
    @player = player()
    
    if(!import(@player.'lightningPunchStatus') || !has_permission("powers.lightningpunch") || pinv(@player,null) != null){
        die()
    }
#    @ploc = ploc(@player) 
#    if(sk_region_check_flag(@ploc,'invincible',@player) == true){
#        tmsg(@player,color(red).'Sorry, you can\'t use lightning here.')
#        die()
#    }
    
    include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
    _coolDown(@player.'lightningPunch',2,@player)

    sudo('/lightning')
}

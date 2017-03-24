bind(entity_damage, null, array('cause': 'FIRE'), @e) {
   
    @plr = player()
    if(@plr != '~console' && has_permission(@plr, "powers.immunity.fire"))
    {
        cancel()
    }
}
bind(entity_damage, null, array('cause': 'FIRE_TICK'), @e) {
   
    @plr = player()
    if(@plr != '~console' && has_permission(@plr, "powers.immunity.fire"))
    {
        cancel()
    }
}

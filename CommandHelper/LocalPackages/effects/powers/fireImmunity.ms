bind(entity_damage, null, array('cause': 'FIRE'), @e) {
   
    @plr = player()
    if(has_permission(@plr, "powers.immunity.fire"))
    {
        cancel()
    }
}

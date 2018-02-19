bind(entity_damage, null, array('type':'/PLAYER/', 'cause': '/FIRE_TICK|FIRE/'), @e) {
   
    if(has_permission(@e['player'], "powers.immunity.fire"))
    {
        cancel()
    }
}

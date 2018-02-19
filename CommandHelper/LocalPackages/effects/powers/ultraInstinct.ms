bind(entity_damage, null, array('type':'/player/','cause': '/ENTITY_ATTACK|CONTACT|PROJECTILE|LIGHTNINIG|FALLING_BLOCK/'), @e) {
   
    if(has_permission(@e['player'], "powers.ultrainstinct"))
    {
        cancel()
        tmsg(@e['player'], color(RED).'Your Ultra Instinct saves you from damage!')
    }
}

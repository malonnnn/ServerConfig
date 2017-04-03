bind(entity_damage, null, array('cause':'ENTITY_ATTACK'), @e) {

    # Required otherwise mobs trigger "index damager does not exist" even with the prefilter
    if(!array_index_exists(@e,'damager') || !ponline(@e['damager'])){
        die()
    }
    @attacker = @e['damager']

    @vicID = @e['id']
    @vicLoc = entity_loc(@vicID)

    if(
        sk_region_check_flag(@vicLoc,'invincible') == true ||
        sk_region_check_flag(@vicLoc,'pvp') == false
    ){
        die()
    }

    if(has_permission(@attacker,'powers.onepunch')){
       modify_event('amount', 9999)
    }
}

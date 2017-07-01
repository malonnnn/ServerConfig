bind(entity_damage, null, array('cause':'ENTITY_ATTACK'), @e) {

    # Required otherwise mobs trigger "index damager does not exist" even with the prefilter
    if(!array_index_exists(@e,'damager') || !ponline(@e['damager'])){
        die()
    }
    @attacker = @e['damager']

    @vicID = @e['id']
    @vicName = ''
    if(@e['type'] == 'PLAYER'){
        @vicName = @e['player']
        try(
            @ploc = ploc(@vicName)
        ,
            cancel()
            die()
        )
    }

    if(@vicName != ''){
        if(sk_region_check_flag(@ploc,'invincible',@vicName) == true){
            die()
        }
        if(sk_region_check_flag(@ploc,'pvp',@vicName) == false){
            die()
        }
    }

    if(has_permission(@attacker,'powers.onepunch')){
        console(@vicName)
		if(@vicName != ''){
			set_peffect(@vicName,11,1,0)
		}
        modify_event('amount', 9999)
    }
}

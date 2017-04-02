bind(entity_damage, null, array('cause': 'ENTITY_ATTACK'), @e) {

    if(ponline(@e['damager'])){
        @attacker = @e['damager']
        @vicID = @e['id']
        if(ponline(@e['player'])){
            @vic = @e['player']
            @vicWorld = pworld(@vic)
            @regions = sk_current_regions(@vic)
            foreach(@rg in @regions){
                @rgFlags = sk_region_info(@rg,@vicWorld)[3]
                foreach(@flag in @rgFlags){
                    if(@flag[0] == 'pvp' || @flag[0] == 'invincible'){
                        if(@flag[1] == 'DENY'){
                            die()
                        }
                    }
                }
            }
        }

        if(has_permission(@attacker,'powers.onepunch')){
            set_entity_health(@vicID,0)
            cancel()
        }
    }
    
}

register_command(batarang,
    array(
        description: 'Throw a batarang',
        permission: 'power.batarang',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {        
            
            @multiplier = 0.5
            @batarang = shoot_projectile(player(), 'SNOWBALL')
            entity_velocity(@batarang)

            bind(entity_damage,array('id':'batarangDamage'.@batarang),null,@e,@batarangg = @batarang){
                unbind('batarang'.@batarangg)
                unbind()
                modify_event('amount',100)
            }
            bind(projectile_hit,array('id':'batarangHit'.@batarang),null,@e,@batarangg = @batarang){
                unbind('batarang'.@batarangg)
                unbind()
            }
        }
    )
)

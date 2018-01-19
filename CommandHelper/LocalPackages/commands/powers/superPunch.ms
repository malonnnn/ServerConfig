register_command(superpunch, 
    array(
        description: 'Power',
        permission: 'powers.superpunch',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@aliases, @sender, @args) {        
            if (array_size(@args) != 0) {
                return(false)
            }
            @player = player()
            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedSuperPunch',5,@player) 
            export(@player.'superPunchActive',TRUE)

            bind(entity_damage, array('id':@player.'superPunch'), array('cause': 'ENTITY_ATTACK'), @e) {
                if(import(@e['damager'].'superPunchActive') == TRUE){
                    @player = @e['damager']
                    unbind()
                    cancel()

    
                    @vic = @e['id']
                    @ploc = ploc(@player)
                    @vicLoc = entity_loc(@vic)

                    include('/home/minecraft/server/plugins/CommandHelper/includes/distanceBetween.ms')
                    @final = _distanceBetween(@ploc,@vicLoc)
                    @maxDist = 30
                    @multiplier = 5
                    
                    @magnitude = (1 - @final / @maxDist) * @multiplier

                    @yaw = @ploc['yaw'] + 90;
                    @pitch = neg(@ploc['pitch']);
                    @vector = associative_array();
                    @vector['x'] = @magnitude * (cos(to_radians(@yaw)) * cos(to_radians(@pitch)));
                    @vector['y'] = @magnitude * sin(to_radians(@pitch));
                    @vector['z'] = @magnitude * (sin(to_radians(@yaw)) * cos(to_radians(@pitch)));
                    if(array_index_exists(@e,'player')){
                        set_pvelocity(@e['player'],@vector)
                    }else{
                        set_entity_velocity(@vic,@vector)
                    }
                }
            }
        }
    )
)

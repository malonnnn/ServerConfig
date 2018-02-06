proc(_isSpecialArrow,@item,@launchEventID){
    if(@item != null){
        if(is_array(@item['meta'])){
            @itemName = @item['meta']['display']

            if(@itemName == color(white).'Arrow of '.color(gray).'Smoke'){
                bind(projectile_hit, null, associative_array(id: @launchEventID), @e){
                    @loc = @e['location']
                    @xStart = @loc['x'] - 1
                    @zStart = @loc['z'] - 1
                    @yStart = @loc['y']
                    @intervalID = set_interval(50, closure(
                        for(@x = @xStart, @x < @xStart + 3, @x++){
                            @loc['x'] = @x
                            for(@z = @zStart, @z < @zStart + 2, @z++){
                                @loc['z'] = @z
                                make_effect(@loc, 'SMOKE:'.rand(9))
                                make_effect(@loc, 'SMOKE:'.rand(9))
                                make_effect(@loc, 'SMOKE:'.rand(9))
                                make_effect(@loc, 'SMOKE:'.rand(9))
                            }
                        }
                        @loc['y'] += 1
                        if(@loc['y'] > @yStart + 2){
                            @loc['y'] = @yStart
                        }
                    ))
                    @blindness = set_interval(500, closure(
                        @plrs = players_in_radius(@e['location'], 4)
                        foreach(@plr in @plrs){
                            set_peffect(@plr, 15, 1, 3, true, false)
                        }
                    ))
                    set_timeout(10000, closure(
                        clear_task(@intervalID)
                        clear_task(@blindness)
                    ))
                    entity_remove(@e['id'])
                }
                return(true)
            }
            if(@itemName == color(white).'Arrow of '.color(dark_red).'Ka-Ba-Boom'){
                bind(projectile_hit, null, associative_array(id: @launchEventID), @e){
                    explosion(@e['location'], 3, true)
                    entity_remove(@e['id'])
                }
                return(true)
            }
            if(@itemName == color(GREEN).'Kryptonite '.color(WHITE).'Arrow'){
                bind(projectile_hit, null, array('id': @launchEventID), @e){
                    if(!is_array(@e['hit'])){
                        @vicID = @e['hit']
                        @vicName = player(@vicID)
                        if(has_permission(@vicName,'weakto.kryptonite')){
                            damage_entity(@vicID,200)
                        }
                    }
                }
                return(true)
            }
            if(@itemName == color(BLUE).'Magic '.color(WHITE).'Arrow'){
                bind(projectile_hit, null, array('id': @launchEventID), @e){
                    if(!is_array(@e['hit'])){
                        @vicID = @e['hit']
                        @vicName = player(@vicID)
                        if(has_permission(@vicName,'weakto.magicarrow')){
                            damage_entity(@vicID,30)
                        }
                    }
                }
                return(true)
            }
            if(@itemName == color(DARK_GRAY).'The Phantom Zone '.color(WHITE).'Arrow'){
                bind(projectile_hit, null, array('id': @launchEventID), @e, @shooter = @pname){
                    if(!is_array(@e['hit'])){
                        @vicID = @e['hit']
                        @vicName = player(@vicID)
                        include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
                        _coolDown('phantomZoneArrow',120,@shooter)
                        sudo('/phantomzonetrap '.@vicName)
                    }
                }
                return(true)
            }
        }
        if(@item['type'] == 262 || @item['type'] == 440 || @item['type'] == 439){
            return(true)
        }else{
            console(@item['type'])
        }
        }
        return(false)
}

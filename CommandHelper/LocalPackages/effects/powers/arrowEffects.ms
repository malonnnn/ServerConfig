bind(projectile_launch, null, array(type: 'ARROW', shootertype: 'PLAYER'), @event) {
    @pname = @event['player']
    @shooterType = @event['shootertype']
    @inv = pinv(@pname)
    @arrowUsed = 'false'
    foreach(@item in @inv)
    {
        if(@item != null && @item['meta'] != null && @item['meta']['display'] != null){
            @arrowName = @item['meta']['display']

            if(@arrowName == color(white).'Arrow of '.color(gray).'Smoke'){
                bind(projectile_hit, null, associative_array(id: @event['id']), @e){
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
                    unbind()
                }
                break()
            }else if(@arrowName == color(white).'Arrow of '.color(dark_red).'Ka-Ba-Boom'){
                bind(projectile_hit, null, associative_array(id: @event['id']), @e){
                    explosion(@e['location'], 3, true)
                    entity_remove(@e['id'])
                    unbind()
                }
                break()
            }else if(@arrowName == color(GREEN).'Kryptonite '.color(WHITE).'Arrow'){
                bind(projectile_hit, null, array('id': @event['id']), @e){
                    if(!is_array(@e['hit'])){
                        @vicID = @e['hit']
                        @vicName = player(@vicID)
                        if(has_permission(@vicName,'weakto.kryptonite')){
                            damage_entity(@vicID,200)
                        }
                    }
                    unbind()
                }
                break()
            }else if(@arrowName == color(BLUE).'Magic '.color(WHITE).'Arrow'){
                bind(projectile_hit, null, array('id': @event['id']), @e){
                    if(!is_array(@e['hit'])){
                        @vicID = @e['hit']
                        @vicName = player(@vicID)
                        if(has_permission(@vicName,'weakto.magicarrow')){
                            damage_entity(@vicID,30)
                        }
                    }
                    unbind()
                }
            }else if(@arrowName == color(DARK_GRAY).'The Phantom Zone '.color(WHITE).'Arrow'){
                bind(projectile_hit, null, array('id': @event['id']), @e, @shooter = @pname){
                    if(!is_array(@e['hit'])){
                        @vicID = @e['hit']
                        @vicName = player(@vicID)
                        include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
                        _coolDown('phantomZoneArrow',120,@shooter)
                        sudo('/phantomzonetrap '.@vicName)
                    }
                    unbind()
                }
                break()
            }

            if(@item['type'] == 262 || @item['type'] == 439 || @item['type'] == 440){
                break()
            }
        }
    }
} 

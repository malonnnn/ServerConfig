bind(projectile_launch, null, associative_array(type: 'ARROW', shootertype: 'PLAYER'), @event) {
    @pname = @event['player']
    @shooterType = @event['shootertype']
    @inv = pinv(@pname)
    @arrowUsed = 'false'
    foreach(@item in @inv)
    {
        if(@item != null && @item['meta'] != null && @item['meta']['display'] != null){
            @arrowName = @item['meta']['display']
            set_timeout(50, closure(
                @bindID = bind(projectile_hit, null, associative_array(type: 'ARROW'), @e, 
                @arrowName) {
                    if(@arrowName == '§fArrow of §4Ka-Ba-Boom')
                    {
                        explosion(@e['location'], 3, true)
                        entity_remove(@e['id'])
                        unbind()
                        die()
                    }else if(@arrowName == '§fArrow of §7Smoke')
                    {
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
                        die()
                    }
                }
            ))
            break()
        }
    } 
}
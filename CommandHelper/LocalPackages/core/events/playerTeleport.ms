bind(player_teleport, null, null, @event,

    if(has_permission('escaperoom.bpass')){
        die()
    }

    @to = @event['to']

    if(@event['from']['world'] != 'escapeworld' && @to['world'] == 'escaperoom'){
        @plrs = all_players('escaperoom')
        @plrss = @plrs
        foreach(@plr in @plrss){
            if(has_permission(@plr,'escaperoom.bypass')){
                array_remove_values(@plrs, @plr)
            }
        }
        if(array_size(@plrs) >= 1){
            tmsg(player(),'someones already playing escape room!')
            console(player().' too many plrs '.@plrs)
            cancel()
        }
    }
)

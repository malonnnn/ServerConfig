bind(player_teleport, null, null, @event,

    @to = @event['to']

    if(@to['world'] == 'escaperoom'){
        @plrs = all_players('escaperoom')
        if(array_size(@plrs) >= 1){
            tmsg(player(),'someones already playing escape room!')
            cancel()
        }
    }
)

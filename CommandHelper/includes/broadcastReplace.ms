proc('_broadcast', @msg, 

    @plrs = all_players()

    foreach(@plr in @plrs){
        tmsg(@plr,@msg)
    }

)

set_interval(5000,closure(
    @players = all_players()
    foreach(@player in @players){
        include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
        @class = _getheroclass(@player)
        try(
        include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms'),
        ,continue())
        if(@hero['op'] == 'true')
        {
            #if(has_permission(@player,"rank.mod") == false){
                @bal = acc_balance(@player)
                if(@bal > 5){
                    acc_subtract(@player,5)
                }else if(@bal < 5 && @bal > 0){
                    acc_subtract(@player,@bal)
                }else{
                    include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
                    _mortal(@player)
                    set_timeout(5000,closure(
                        tmsg(@player,color(red).color(bold)."You have been returned to a mortal because you were an OP character and ran out of money,")
                    ))
                }
            #}
        }
    }
))

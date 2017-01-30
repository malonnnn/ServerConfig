set_interval(5000,closure(
    @players = all_players()

    foreach(@player in @players){
        @class = pgroup(@player)[0]
        try(
        include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms'),
        ,continue())
        if(@hero['op'] == 'true')
        {
            if(has_permission(@player,"rank.mod") == false){
                @bal = acc_balance(@player)
                if(@bal > 0){
                    acc_subtract(@player,1)
                }else{
                    runas(~console,"/sudo ".@player." c:/mortal")
                    set_timeout(5000,closure(
                        tmsg(@player,color(red).color(bold)."You have been returned to a mortal because you were an OP hero and ran out of money")
                    ))
                }
            }
        }
    }
))

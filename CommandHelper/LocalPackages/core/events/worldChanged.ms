bind(world_changed, null, null, @event,

    @player = player()

    @to = @event['to']
    @from = @event['from']
    @class = pgroup()[0]

    set_timeout(3000,closure(    
        runas(~console,"/effect ".@player." invisibility 0")
        runas(~console,"/sudo ".@player." c:/fixskin")
    ))

    if(@to == 'greenfield' && @class == 'mortal'){
        runas(~console,'/effect '.@player." clear")
        runas(~console,'/minecraft:clear '.@player)
    }
    if(@to == 'anarchy' && @class != 'anarchy'){
        runas(~console,'/pex user '.@player.' group set anarchy')
    }
    if(@to == 'alpha'){
        runas(~console,'/effect '.@player.' clear')
    }

    if(@to != 'policeoffice'){
        if(has_permission(@player,'is.onduty') && !has_permission(@player,'police.chief')){
            set_timeout(120000,closure(
                include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
                _mortal(@player)
            ))
        }
    }
    
    if(@from == 'fightclub'){
        export(@player.'fightClub','')
        @winner = import(@player.'fcvs')
        if(@winner != '' && @winner != null){
            include('/home/minecraft/server/plugins/CommandHelper/includes/fightClubReset.ms')
            _fightClubReset(@winner,@player)
        }
    }

)

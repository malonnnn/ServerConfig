bind(world_changed, null, null, @event,

    @player = player()

    @to = @event['to']
    @from = @event['from']
    @class = pgroup()[0]
    
    set_entity_fall_distance(puuid(@player),0.0)
    runas(~console,"/fly ".@player." off")

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
    
    if(@from == 'fightclub'){
        export(@player.'fightClub','')
        @winner = import(@player.'fcvs')
        if(@winner != '' && @winner != null){
            include('/home/minecraft/server/plugins/CommandHelper/includes/fightClubReset.ms')
            _fightClubReset(@winner,@player)
        }
    }

)

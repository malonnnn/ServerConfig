bind(world_changed, null, null, @event,

    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
    @player = player()

    @to = @event['to']
    @from = @event['from']
    @class = _getheroclass(@player)

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
    

)

bind(world_changed, null, null, @event,

    @player = player()

    @to = @event['to']
    @from = @event['from']
    @class = pgroup()[0]

    if(@to == 'greenfield' && @class = 'mortal'){
        runas(~console,'/effect '.@player." clear")
        runas(~console,'/minecraft:clear '.@player)
    } else if(@to == 'anarchy' && @class != 'anarchy'){
        runas(~console,'/pex user '.@player.' group set anarchy')
    }
    

)

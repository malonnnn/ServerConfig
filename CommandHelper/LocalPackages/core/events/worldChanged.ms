bind(world_changed, null, null, @event,

    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
    @player = player()

    @to = @event['to']
    @from = @event['from']
    @class = _getheroclass(@player)

    set_timeout(3000,closure(
        if(has_permission('in.survival')){
            runas(~console,"/effect ".@player." clear")
            runas(~console,"/minecraft:clear ".@player)
            runas(~console,"/sudo ".@player." c:/fixskin")
            set_pflight(@player,false)
        }
    ))

    if(@to == 'anarchy' && @class != 'anarchy'){
        runas(~console,'/pex user '.@player.' group set anarchy')
    }
    

)

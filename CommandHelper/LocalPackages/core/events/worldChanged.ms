bind(world_changed, null, null, @event,

#    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
    @player = player()

#    @to = @event['to']
#    @from = @event['from']
#    @class = _getheroclass(@player)

    set_timeout(1000,closure(
        runas(~console,"/minecraft:effect ".@player." clear")
        runas(~console,"/minecraft:clear ".@player)
        set_pflight(@player,false)
        include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
        @class = _getheroclass(@player)
        if(@class == 'mortal' || substr(@class,0,6) == 'fanfic'){
            runas(~console,'/undisguiseplayer '.@player)
        }else{
            @skinNum = import(@player.'skinNum')
            if(@skinNum != null){
                runas(@player,'/skin '.@skinNum)
            }
        }
        if(has_permission(@player,'essentials.fly')){
            run_cmd('/fly')
        }
        if(has_permission(@player,'ch.alias.buff')){
            runas(@player,'/buff')
        }
        runas(~console,'/effect '.@player.' regeneration 5 10 true')
        set_peffect(@player,14,1,0)
    ))

#    if(@to == 'anarchy' && @class != 'anarchy'){
#        runas(~console,'/pex user '.@player.' group set anarchy')
#    }
)

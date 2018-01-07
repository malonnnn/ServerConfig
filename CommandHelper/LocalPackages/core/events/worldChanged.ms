bind(world_changed, null, null, @event,

#    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
    @player = player()

#    @to = @event['to']
#    @from = @event['from']
#    @class = _getheroclass(@player)

    set_timeout(1000,closure(
#        if(has_permission('is.incity')){
            runas(~console,"/minecraft:effect ".@player." clear")
            runas(~console,"/minecraft:clear ".@player)
            set_pflight(@player,false)
#        }else if(!has_permission('in.survival')){
            runas(~console,"/sudo ".@player." c:/fixskin")
        if(has_permission(@player,'essentials.fly')){
            run_cmd('/fly')
        }
            set_peffect(@player,14,1,0)
#        }else{
#            set_pflight(@player,false)
#        }
    ))

#    if(@to == 'anarchy' && @class != 'anarchy'){
#        runas(~console,'/pex user '.@player.' group set anarchy')
#    }
)

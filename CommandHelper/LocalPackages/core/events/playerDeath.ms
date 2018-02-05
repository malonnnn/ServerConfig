bind(player_death, null, null, @event,

    if(@event['cause']['cause'] == 'VOID'){
        die()
    }

    @player = player()
    @world = pworld()
   
    runas(~console,'/minecraft:clear '.@player) 
    if(@world == 'deathrun'){
        runas(~console,'/timer &4DeathRun split '.@player.' global')
    }

    if(has_permission(@player,'powers.cantdie')){
        set_phealth(@player,1)
        modify_event('death_message',null)
    }

    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
    @deadPersonClass = _getheroclass(@player)
    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@deadPersonClass.'.ms')
    @dHero = @hero
    modify_event('player',@dHero['name'].color(WHITE))
    if(array_index_exists(@event,'killer')){
        @alivePersonClass = _getheroclass(@event['killer'])
        include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@alivePersonClass.'.ms')
        @aHero = @hero
        modify_event('killer',@aHero['name'].color(WHITE))
    }

)

bind(player_death, null, null, @event,

    @player = player()
    @world = pworld()
    
    if(@world == 'deathrun'){
        runas(~console,'/timer &4DeathRun split '.@player.' global')
    }
)

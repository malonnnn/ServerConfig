bind(player_death, null, null, @event,
    @player = player()
    @world = pworld()
    
    if(@world == 'deathrun'){
        runas(~console,'/timer &4DeathRun split '.@player.' global')
    }

    if(has_permission(@player,'powers.cantdie')){
        set_phealth(@player,1)
        modify_event('death_message',null)
    }
)

bind(player_spawn, null, null, @event,

    @player = @event['player']

    if(has_permission(@player,'ch.alias.buff')){
        runas(@player,'/buff')
        runas(~console,'/healing '.@player)
    }

)

bind(player_consume,null,null,@event){

    if(@event['item']['meta']['display'] == '§aI§2vy §aS§2eed'){
        cancel()
        damage_entity(puuid(@event['player']),60)
        set_pinv(array(null: array(type: null)))
        broadcast(@event['player'].' ate an Ivy Seed and sustained massive damage!')
    }

}

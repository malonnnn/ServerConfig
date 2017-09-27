bind(player_portal_travel, null, null, @event){
    @to = @event['to']
    console(@to)
    try{
        get_spawn(@to['world'])
    }catch(InvalidWorldException @e){
        console('off')
        cancel()
        msg(color(RED).'Sorry, that world does not exist')
        @from = @event['from']
        sudo('/mv tp '.@from['world'])
        die()
    }
}
bind(player_portal_travel, null, null, @event){
    @to = @event['to']
    if(@to == null){
        cancel()
        msg(color(RED).'Sorry, that world does not exist')
        @from = @event['from']
        sudo('/mv tp '.@from['world'])
        die()
    }
}
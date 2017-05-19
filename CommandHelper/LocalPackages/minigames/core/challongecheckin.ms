register_command('challonge create', 

    array(
    
        description: 'Creates a tournament',
        usage: '/challonge create <tournamentName> <minigameType>',
        permission: 'challonge',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
            if (array_size(@args) != 2) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /challonge create <tourmamentName> <minigameType>');
                die(); # No need to go further					
            }
            
            @minigameName = @args[0]
            @minigameType = @args[1]
            @plr = player()
            # @challongeKey gets initialized behind the scenes when doing this include
            include('/home/minecraft/server/plugins/CommandHelper/includes/challongeKey.ms')
            tmsg(@plr,color(red).'Creating tournament...')
            if(@type == 'create'){
                @url = 'https://api.challonge.com/v1/tournaments.json'
                http_request(@url, array(
                    method: 'POST',
                    headers: array(
                     // The content type isn't set automatically if we send a string via params,
                     // so we have to set this manually to application/json here, since we're sending
                     // json data. Other data types may have different MIME types.
                     'Content-Type': 'application/json'
                    ),   params: json_encode(array(
                     'api_key': @challongeKey,
                     'name': 'test',
                     'url': @minigameType.'_'.time(),
                    )),
                    success: closure(@response){
                    tmsg(@plr,color(red).'Done!')
                }));
            }
        }
    )
)

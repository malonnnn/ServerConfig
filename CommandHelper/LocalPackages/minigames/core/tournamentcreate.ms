register_command('tournamentcreate', 

    array(
    
        description: 'Create a tournament',
        usage: '/tournamentcreate <tournamentName>',
        permission: 'tournament.starcreate',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {

            @plr = player()
            assign(@cooldown, 60)
            assign(@lastUsedTournamentCreate, import(@plr."lastUsedTournamentCreate"))
            if(@lastUsedTournamentCreate + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedTournamentCreate, @cooldown), divide(time(),1000)))
                tmsg(@plr,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can create another tournament!'))
                die()
            )

            if (array_size(@args) != 1) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /tournamentcreate <tournamentName>');
                die(); # No need to go further					
            }

            @tournamentName = @args[0]

            # @challongeKey gets initialized behind the scenes when doing this include
            include('/home/minecraft/server/plugins/CommandHelper/includes/challongeKey.ms')

            @url = 'https://api.challonge.com/v1/tournaments.json'
            @puuid = puuid(@plr,true)
            @prevTourn = get_value(@puuid.'tournamentOwned')
            if(@prevTourn != null && @prevTourn != ''){
                msg(color(RED).'Sorry, you are already running a different tournament! Please first do /tournamentcancel '.@prevTourn)
                die()
            }
            tmsg(@plr,color(red).'Creating tournament...')
            http_request(@url, array(
                method: 'POST',
                headers: array(
                 // The content type isn't set automatically if we send a string via params,
                 // so we have to set this manually to application/json here, since we're sending
                 // json data. Other data types may have different MIME types.
                 'Content-Type': 'application/json'
                ),   params: array(
                 'api_key': @challongeKey,
                 'tournament[name]': @tournamentName,
                 'tournament[url]': @tournamentName.'_omnivs',
                 'tournament[tournament_type]': 'double elimination',
                ),
                success: closure(@response){
                if(@response['responseCode'] != 200){
                    tmsg(@plr,color(red).'Error!')
                    @error = json_decode(@response['body'])
                    foreach(@error in @error['errors']){
                        if(@error == 'URL has already been taken'){
                            tmsg(@plr,color(red).'Name has already been taken')
                        }else{
                            tmsg(@plr,color(red).@error)
                        }
                    }
                    die()
                }
                @tournamentInfo = json_decode(@response['body'])
                store_value(@puuid.'tournamentOwned',@tournamentName)
                store_value(@tournamentName.'tournamentOwner',@puuid)
                broadcast(color(RED).'Tournament '.@tournamentName.' is now taking signups! /tournamentjoin '.@tournamentName)
                export(@plr."lastUsedTournamentCreate", time() / 1000)
            }));
        }
    )
)

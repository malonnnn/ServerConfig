register_command('tournamentstart', 

    array(
    
        description: 'Starts a tournament',
        usage: '/tournamentstart <tournamentName>',
        permission: 'tournament.create',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
            @plr = player()
            assign(@cooldown, 60)
            assign(@lastUsedTournamentStart, import(@plr."lastUsedTournamentStart"))
            if(@lastUsedTournamentStart + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedTournamentStart, @cooldown), divide(time(),1000)))
                tmsg(@plr,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can start another tournament!'))
                die()
            )
            if (array_size(@args) != 1) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /tournamentcreate <tournamentName>');
                die(); # No need to go further					
            }

            @tournamentName = @args[0]
            @tournamentURL = @tournamentName.'_omnivs'

            if(get_value(@tournamentName.'tournamentOwner') != puuid(@plr,true)){
                tmsg(@plr,color(red).'Sorry, you don\'t appear to be the owner of that tournament!')
                die()
            }

            # @challongeKey gets initialized behind the scenes when doing this include
            include('/home/minecraft/server/plugins/CommandHelper/includes/challongeKey.ms')

            @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/participants/randomize.json'
            tmsg(@plr,color(red).'Starting tournament...')
            http_request(@url, array(
                method: 'POST',
                headers: array(
                 'Content-Type': 'application/json'
                ),   params: json_encode(array(
                 'api_key': @challongeKey,
                )),
                success: closure(@response){
                    if(@response['responseCode'] != 200){
                        tmsg(@plr,color(red).'Error!')
                        @error = json_decode(@response['body'])
                        foreach(@error in @error['errors']){
                            tmsg(@plr,color(red).@error)
                        }
                        die()
                    }
                    @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/start.json'
                    http_request(@url, array(
                        method: 'POST',
                        headers: array(
                         'Content-Type': 'application/json'
                        ),   params: json_encode(array(
                         'api_key': @challongeKey,
                        )),
                        success: closure(@response){
                            if(@response['responseCode'] != 200){
                                tmsg(@plr,color(red).'Error!')
                                @error = json_decode(@response['body'])
                                foreach(@error in @error['errors']){
                                    tmsg(@plr,color(red).@error)
                                }
                                die()
                            }
                            export(@plr."lastUsedTournamentStart", time() / 1000)
                            broadcast(color(red).'Tournament '.@tournamentName.' has started!')
                        }
                    ))
                }
            ))
        }
    )
)

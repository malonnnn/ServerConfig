register_command('tournamentdelete', 

    array(
    
        description: 'Delete a tournament',
        usage: '/tournamentdelete <tournamentName>',
        permission: 'tournament.delete',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {

            @plr = player()
            assign(@cooldown, 60)
            assign(@lastUsedTournamentDelete, import(@plr."lastUsedTournamentDelete"))
            if(@lastUsedTournamentDelete + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedTournamentDelete, @cooldown), divide(time(),1000)))
                tmsg(@plr,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can cancel another tournament!'))
                die()
            )

            if (array_size(@args) != 1) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /tournamentdelete <tournamentName>');
                die(); # No need to go further					
            }

            @tournamentName = to_lower(@args[0])
            @tournamentURL = @tournamentName.'_omnivs'
            @puuid = puuid(@plr,true)
            if(get_value(@puuid.'tournamentOwned') != @tournamentName){
                msg(color(RED).'Sorry, only the tournament owner can do that!')
                die()
            }

            # @challongeKey gets initialized behind the scenes when doing this include
            include('/home/minecraft/server/plugins/CommandHelper/includes/challongeKey.ms')

            @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'.json'
            tmsg(@plr,color(red).'Deleting tournament '.@tournamentName)
            http_request(@url, array(
                method: 'POST',
                headers: array(
                 // The content type isn't set automatically if we send a string via params,
                 // so we have to set this manually to application/json here, since we're sending
                 // json data. Other data types may have different MIME types.
                 // 'Content-Type': 'application/json'
                ),   params: array(
                 'api_key': @challongeKey,
                 '_method': 'delete',
                ),
                success: closure(@response){
                    if(@response['responseCode'] != 200){
                        @error = json_decode(@response['body'])
                        foreach(@error in @error['errors']){
                            if(@error == 'URL has already been taken'){
                                tmsg(@plr,color(red).'Name has already been taken')
                            }
                        }
                    }
                    @puuid = puuid(@plr,true)
                    store_value(@puuid.'tournamentOwned','')
                    store_value(@tournamentName.'tournamentOwner','')
                    msg(color(RED).'The tournament '.@tournamentName.' has been deleted!')
                    export(@plr."lastUsedTournamentDelete", time() / 1000)
                }
            ));
        }
    )
)

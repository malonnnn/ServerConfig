register_command('tournamentmatchwinner', 

    array(
    
        description: 'Choose a tournament match winner',
        usage: '/tournamentmatchwinner <matchWinner>',
        permission: 'tournament.matchwinner',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
            @plr = player()
            assign(@cooldown, 15)
            assign(@lastUsedTournamentMatchWinner, import(@plr."lastUsedTournamentMatchWinner"))
            if(@lastUsedTournamentMatchWinner + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedTournamentMatchWinner, @cooldown), divide(time(),1000)))
                tmsg(@plr,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can pick another match!'))
                die()
            )
            export(@plr."lastUsedTournamentMatchWinner", time() / 1000)
            if (array_size(@args) != 1) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /tournamentmatchwinner <matchWinner>');
                die(); # No need to go further					
            }
            @puuid = puuid(@plr,true)
            @matchWinner = @args[0]
            @tournamentName = get_value(@puuid.'tournamentOwned')
            @tournamentURL = @tournamentName.'_omnivs'
            @remainingMatches = ''

            # @challongeKey gets initialized behind the scenes when doing this include
            include('/home/minecraft/server/plugins/CommandHelper/includes/challongeKey.ms')

            tmsg(@plr,color(red).'Setting match winner to '.@matchWinner.'...')

            @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/matches.json'
            http_request(@url, array(
                method: 'GET',
                headers: array(
                    'Content-Type': 'application/json'
                ),
                params: array(
                    'api_key': @challongeKey,
                ),
                success: closure(@response){
                    if(@response['responseCode'] != 200){
                        tmsg(@plr,@response) 
                        tmsg(@plr,color(red).'Error!')
                        @error = json_decode(@response['body'])
                        foreach(@error in @error['errors']){
                            tmsg(@plr,color(red).@error)
                        }
                        die()
                    }
                    @remainingMatches = json_decode(@response['body'])
                    @match = @remainingMatches[0]
                    @player1Wins = true
                    @winnerID = get_value(@puuid.@tournamentName.'participantID')
                    @score = '1-0'
                    @finalMatch = true
                    msg(@remainingMatches[0]['match']['player1_id'])
                    foreach(@match as @remainingMatches){
                        if(@match['match']['player1_id'] != @winnerID && @match['match']['player2_id'] != @winnerID){
                            continue()
                        }
                        if(@match['player1_id'] == @winnerID){
                            @score = '1-0'
                        }else if(@match['player2_id'] == @winnerID){
                            @score = '1-0'
                            @player1Wins = false
                        }
                        @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/matches/'.@match['id'].'.json'
                        http_request(@url, array(
                            method: 'PUT',
                            headers: array(
                             // The content type isn't set automatically if we send a string via params,
                             // so we have to set this manually to application/json here, since we're sending
                             // json data. Other data types may have different MIME types.
                             'Content-Type': 'application/json'
                            ),   params: json_encode(array(
                             'api_key': @challongeKey,
                             'winner_id': @winnerID,
                             'scores_scv': @score,
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
                                @confirmation = json_decode(@response['body'])
                                @finalMatch = true
                                foreach(@match in @remainingMatches){
                                    if(@match['state'] == 'open'){
                                        @finalMatch = false
                                    }
                                }
                                if(@finalMatch){
                                    @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/finalize.json'
                                    http_request(@url, array(
                                        method: 'POST',
                                        headers: array(
                                         // The content type isn't set automatically if we send a string via params,
                                         // so we have to set this manually to application/json here, since we're sending
                                         // json data. Other data types may have different MIME types.
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
                                            broadcast(color(RED).@matchWinner.color(RED).' is the winner of the '.color(WHITE).@tournamentName.color(RED).' tournament! Please visit '.color(GREEN).'http://challonge.com/'.@tournamentURL.color(RED).' to see the full standings!')
                                            store_value(@puuid.'tournamentOwned','')
                                            store_value(@tournamentName.'tournamentID','')
                                            store_value(@tournamentName.'tournamentOwner','')
                                        }
                                    ))
                                }
                                tmsg(@plr,color(red).'You have checked into the '.@tournamentName.' tournament!')
                            }
                        ))
                    }
                }
            ))
        }
    )
)

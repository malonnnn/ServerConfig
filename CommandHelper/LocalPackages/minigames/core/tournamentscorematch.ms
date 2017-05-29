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
            if (array_size(@args) != 1) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /tournamentmatchwinner <matchWinner>');
                die(); # No need to go further					
            }
            @puuid = puuid(@plr,true)
            @matchWinner = @args[0]
            try{
                @matchWinner = player(@matchWinner)
            }catch(PlayerOfflineException @e){
                msg(color(RED).'Sorry, that player is not online D:')
                die()
            }
            @tournamentName = get_value('tournament.'.@puuid.'tournamentOwned')
            @tournamentURL = @tournamentName.'_omnivs'
            @remainingMatches = ''
            @winnerID = get_value('tournament.'.puuid(@matchWinner,true).@tournamentName.'participantID')

            # @challongeKey gets initialized behind the scenes when doing this include
            include('/home/minecraft/server/plugins/CommandHelper/includes/challongeKey.ms')

            tmsg(@plr,color(red).'Setting match winner to '.@matchWinner.'...')

            @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/matches.json'
            http_request(@url, array(
                method: 'GET',
                params: array(
                    'api_key': @challongeKey,
                    'state': 'open',
                ),
                success: closure(@response){
                    if(@response['responseCode'] != 200){
                        tmsg(@plr,color(red).'error!')
                        @error = json_decode(@response['body'])
                        foreach(@error in @error['errors']){
                            tmsg(@plr,color(red).@error)
                        }
                        die()
                    }

                    @remainingMatches = json_decode(@response['body'])
                    @player1Wins = ''
                    @matchID = ''
                    @score = ''
                    
                    @matchID = @remainingMatches[0]['match']['id']
                    if(@remainingMatches[0]['match']['player1_id'] == @winnerID){
                        @score = '1-0'
                        @player1Wins = true
                    }else if(@remainingMatches[0]['match']['player2_id'] == @winnerID){
                        @score = '0-1'
                        @player1Wins = false
                    }else{
                        msg(color(RED).'Sorry, we can\'t find that player D: Are you sure they are up next? Find out with '.color(WHITE).'/tournamentwhosup '.@tournamentName.color(RED).' and if they actually up, do '.color(WHITE).'/tournamentleave '.@tournamentName.' '.@matchWinner)
                        die() 
                    }

                    @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/matches/'.@matchID.'.json'
                    http_request(@url, array ( # Update the winner's score and set them as winner
                        method: 'POST',
                        params: array(
                         'api_key': @challongeKey,
                         '_method': 'put',
                         'match[scores_csv]': @score,
                         'match[winner_id]': @winnerID,
                        ),
                        success: closure(@response2){
                            if(@response2['responseCode'] != 200){
                                tmsg(@plr,color(red).'Error!')
                                @error = json_decode(@response2['body'])
                                foreach(@error in @error['errors']){
                                    tmsg(@plr,color(red).@error)
                                }
                                die()
                            }
                            
                            @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/matches.json'
                            http_request(@url, array(
                                method: 'GET',
                                params: array(
                                    'api_key': @challongeKey,
                                    'state': 'open',
                                ),
                                success: closure(@response){
                                    if(@response['responseCode'] != 200){
                                        tmsg(@plr,color(red).'error!')
                                        @error = json_decode(@response['body'])
                                        foreach(@error in @error['errors']){
                                            tmsg(@plr,color(red).@error)
                                        }
                                        die()
                                    }
                                    @remainingMatches = json_decode(@response['body'])
                                    if(array_size(@remainingMatches) == 0){ # If it was the last match, finalize it
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
                                            success: closure(@response3){
                                                if(@response3['responseCode'] != 200){
                                                    continue()
                                                }else{
                                                    export(@plr."lastUsedTournamentMatchWinner", time() / 1000)
                                                    broadcast(color(RED).@matchWinner.color(RED).' is the winner of the '.color(WHITE).@tournamentName.color(RED).' tournament! Please visit '.color(GREEN).'http://challonge.com/'.@tournamentURL.color(RED).' to see the full standings!')
                                                    store_value('tournament.'.@puuid.'tournamentOwned','')
                                                    store_value('tournament.'.@tournamentName.'tournamentID','')
                                                    store_value('tournament.'.@tournamentName.'tournamentOwner','')
                                                }
                                            }
                                        ))
                                    }else{ # If there's more matches to go
                                        @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/matches.json'
                                        http_request(@url, array( # Get the remaining matches with people in them
                                            method: 'GET',
                                            headers: array(
                                                'Content-Type': 'application/json'
                                            ),
                                            params: array(
                                                'api_key': @challongeKey,
                                                'state': 'open',
                                            ),
                                            success: closure(@response4){
                                                if(@response['responseCode'] != 200){
                                                    tmsg(@plr,@response4) 
                                                    tmsg(@plr,color(red).'Error!')
                                                    @error = json_decode(@response4['body'])
                                                    foreach(@error in @error['errors']){
                                                        tmsg(@plr,color(red).@error)
                                                    }
                                                    die()
                                                }
                                                @matchNumber = 0
                                                @matches = json_decode(@response4['body'])
                                                @player1ID = @matches[@matchNumber]['match']['player1_id']
                                                @player2ID = @matches[@matchNumber]['match']['player2_id']
                                                @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/participants/'.@player1ID.'.json'
                                                http_request(@url, array( # Get Player 1's name
                                                    method: 'GET',
                                                    headers: array(
                                                        'Content-Type': 'application/json'
                                                    ),
                                                    params: array(
                                                        'api_key': @challongeKey,
                                                    ),
                                                    success: closure(@response5){
                                                        if(@response5['responseCode'] != 200){
                                                            msg(@response5) 
                                                            tmsg(@plr,color(red).'Error!')
                                                            @error = json_decode(@response5['body'])
                                                            foreach(@error in @error['errors']){
                                                                tmsg(@plr,color(red).@error)
                                                            }
                                                            die()
                                                        }
                                                        @player1 = json_decode(@response5['body'])
                                                        @player1Name = @player1['participant']['name']
                                                        @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/participants/'.@player2ID.'.json'
                                                        http_request(@url, array( # Get Player 2's name
                                                            method: 'GET',
                                                            headers: array(
                                                                'Content-Type': 'application/json'
                                                            ),
                                                            params: array(
                                                                'api_key': @challongeKey,
                                                            ),
                                                            success: closure(@response6){
                                                                if(@response6['responseCode'] != 200){
                                                                    msg(@response6) 
                                                                    tmsg(@plr,color(red).'Error!')
                                                                    @error = json_decode(@response6['body'])
                                                                    foreach(@error in @error['errors']){
                                                                        tmsg(@plr,color(red).@error)
                                                                    }
                                                                    die()
                                                                }
                                                                export(@plr."lastUsedTournamentMatchWinner", time() / 1000)
                                                                @player2 = json_decode(@response6['body'])
                                                                @player2Name = @player2['participant']['name']
                                                                broadcast(@matchWinner.color(RED).color(BOLD).' won the last match! The next match will be '.color(WHITE).@player1Name.color(RED).color(BOLD)' vs. '.color(WHITE).@player2Name)
                                                            }
                                                        ))
                                                    }
                                                ))
                                            }
                                        ))
                                    }
                                }
                            ))
                        }
                    ))
                }
            ))
        }
    )
)

register_command('tournamentleave', 

    array(
    
        description: 'Leaves a joined tournament',
        usage: '/tournamentleave <tournamentName> <playerName>',
        permission: 'tournament.leave',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
         
            @plr = player()
            assign(@cooldown, 15)
            assign(@lastUsedTournamentLeave, import(@plr."lastUsedTournamentLeave"))
            if(@lastUsedTournamentLeave + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedTournamentLeave, @cooldown), divide(time(),1000)))
                tmsg(@plr,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can leave another tournament!'))
                die()
            )
            export(@plr."lastUsedTournamentLeave", time() / 1000)
            if (array_size(@args) > 2) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /tournamentleave <touranmentName>');
                die(); # No need to go further					
            }
            if (array_size(@args) < 1) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /tournamentleave <touranmentName>');
                die(); # No need to go further					
            }
            
            # Person leaving is assumed to be the player
            @personLeaving = @plr
            @puuid = puuid(@plr,true)
            @tournamentName = @args[0]
            @tournamentURL = @tournamentName.'_omnivs'
            @participantID = get_value(@puuid.@tournamentName.'participantID')

            # @challongeKey gets initialized behind the scenes when doing this include
            include('/home/minecraft/server/plugins/CommandHelper/includes/challongeKey.ms')

            # If the 2nd argument is the name of one of the players in the match, they will be removed
            if(array_size(@args) == 2){
                @tournamentOwner = get_value(@tournamentName.'tournamentOwner')
                if(@puuid == @tournamentOwner){
                    @personLeaving = @args[1]
                    # If the target player is currently online, just get their tournament ID number
                    # from the database
                    # Otherwise query the server to figure out their ID
                    try{
                        @personLeaving = player(@personLeaving)
                    }catch(PlayerOfflineException @e){
                        # Get the list of all upcoming matches, then grab the 1st one
                        @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/matches.json'
                        http_request(@url, array(
                            method: 'GET',
                            headers: array(
                                'Content-Type': 'application/json'
                            ),
                            params: array(
                                'api_key': @challongeKey,
                                '_method': 'delete',
                                'state': 'open',
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
                                @match = json_decode(@response['body'])[0]['match']

                                @player1ID = @match['player1_id']
                                @player2ID = @match['player2_id']

                                # Query Player 1's ID to check their username
                                @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/participants/'.@player1ID.'.json'
                                http_request(@url, array(
                                    method: 'GET',
                                    headers: array(
                                        'Content-Type': 'application/json'
                                    ),
                                    params: array(
                                        'api_key': @challongeKey,
                                    ),
                                    success: closure(@response2){
                                        if(@response2['responseCode'] != 200){
                                            tmsg(@plr,@response2) 
                                            tmsg(@plr,color(red).'Error!')
                                            @error = json_decode(@response2['body'])
                                            foreach(@error in @error['errors']){
                                                tmsg(@plr,color(red).@error)
                                            }
                                            msg('DED')
                                            die()
                                        }

                                        @person = json_decode(@response2['body'])['participant']

                                        # If the queried name matches the typed name, remove said player
                                        # Otherwise we continue on by querying Player 2 and checking his name
                                        if(@person['name'] == @personLeaving){
                                            @participantID = @player1ID
                                            @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/participants/'.@participantID.'.json'
                                            http_request(@url, array(
                                                method: 'POST',
                                                headers: array(
                                                    'Content-Type': 'application/json'
                                                ),
                                                params: array(
                                                    'api_key': @challongeKey,
                                                    '_method': 'delete',
                                                ),
                                                success: closure(@response3){
                                                    if(@response3['responseCode'] != 200){
                                                        tmsg(@plr,@response3) 
                                                        tmsg(@plr,color(red).'Error!')
                                                        @error = json_decode(@response3['body'])
                                                        foreach(@error in @error['errors']){
                                                            tmsg(@plr,color(red).@error)
                                                        }
                                                        die()
                                                    }
                                                    @person = json_decode(@response3['body'])['participant']
                                                    @puuid = @person['misc']
                                                    tmsg(@plr,@person['name'].color(RED).' has been removed!')
                                                    store_value(@puuid.@tournamentName.'participantID','')
                                                }
                                            ))
                                        }else{ # If Player 1's name did not match the typed name, then examine Player 2
                                            @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/participants/'.@player2ID.'.json'
                                            http_request(@url, array(
                                                method: 'GET',
                                                headers: array(
                                                    'Content-Type': 'application/json'
                                                ),
                                                params: array(
                                                    'api_key': @challongeKey,
                                                ),
                                                success: closure(@response4){
                                                    if(@response4['responseCode'] != 200){
                                                        tmsg(@plr,@response4) 
                                                        tmsg(@plr,color(red).'Error!')
                                                        @error = json_decode(@response4['body'])
                                                        foreach(@error in @error['errors']){
                                                            tmsg(@plr,color(red).@error)
                                                        }
                                                        die()
                                                    }
                                                    @person = json_decode(@response4['body'])['participant']

                                                    # If Player 2 matches the typed named, remove that player
                                                    if(@person['name'] == @personLeaving){
                                                        @participantID = @player2ID
                                                        @puuid = @person['misc']
                                                        @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/participants/'.@participantID.'.json'
                                                        http_request(@url, array(
                                                            method: 'POST',
                                                            headers: array(
                                                                'Content-Type': 'application/json'
                                                            ),
                                                            params: array(
                                                                'api_key': @challongeKey,
                                                                '_method': 'delete',
                                                            ),
                                                            success: closure(@response5){
                                                                if(@response5['responseCode'] != 200){
                                                                    tmsg(@plr,@response5) 
                                                                    tmsg(@plr,color(red).'Error!')
                                                                    @error = json_decode(@response5['body'])
                                                                    foreach(@error in @error['errors']){
                                                                        tmsg(@plr,color(red).@error)
                                                                    }
                                                                    die()
                                                                }
                                                                @person = json_decode(@response5['body'])['participant']
                                                                @puuid = @person['misc']
                                                                tmsg(@plr,@person['name'].color(RED).' has been removed!')
                                                                store_value(@puuid.@tournamentName.'participantID','')
                                                            }
                                                        ))
                                                    }else{ # If player 1 and player 2 don't match, throw this error
                                                        msg(color(RED).'Are you sure that person is in that match? If they are offline, then you need to type their name EXACTLY. Double check by doing '.color(WHITE).'/tournamentwhosup '.@tournamentName)
                                                        die()
                                                    }
                                                }
                                            ))
                                        }
                                    }
                                ))
                            }
                        ))
                    }
                }else{
                    msg(color(RED).'Sorry, only the tournament owner can do that!')
                    die()
                }
            }else{
                if(@participantID == null || @participantID == ''){
                    msg(color(RED).'Sorry, it doesn\'t look like you\'re a part of that tournament!')
                    die()
                }

                tmsg(@plr,color(red).'Leaving tournament...')
                @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/participants/'.@participantID.'.json'
                http_request(@url, array(
                    method: 'POST',
                    headers: array(
                        'Content-Type': 'application/json'
                    ),
                    params: array(
                        'api_key': @challongeKey,
                        '_method': 'delete',
                    ),
                    success: closure(@response6){
                        if(@response6['responseCode'] != 200){
                            tmsg(@plr,@response6) 
                            tmsg(@plr,color(red).'Error!')
                            @error = json_decode(@response6['body'])
                            foreach(@error in @error['errors']){
                                tmsg(@plr,color(red).@error)
                            }
                            die()
                        }
                        tmsg(@plr,color(red).'Success!')
                        store_value(@puuid.@tournamentName.'participantID','')
                    }
                ))
            }
        }
    )
)

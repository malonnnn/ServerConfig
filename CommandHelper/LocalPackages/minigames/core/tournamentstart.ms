register_command('tournamentstart', 

    array(
    
        description: 'Starts a tournament',
        usage: '/tournamentstart <tournamentName>',
        permission: 'tournament.start',
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

            @tournamentName = to_lower(@args[0])
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
                            broadcast(color(red).'Tournament '.@tournamentName.' has started!'.color(GREEN).' http://challonge.com/'.@tournamentURL)
                            @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/matches.json'
                            http_request(@url, array(
                                method: 'GET',
                                headers: array(
                                    'Content-Type': 'application/json'
                                ),
                                params: array(
                                    'api_key': @challongeKey,
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
                                    @matchNumber = 0
                                    @matches = json_decode(@response['body'])
                                    if(array_size(@matches) > @matchNumber && @matchNumber >= 0){
                                        @player1ID = @matches[@matchNumber]['match']['player1_id']
                                        @player2ID = @matches[@matchNumber]['match']['player2_id']
                                    }else{
                                        msg(color(RED).'Sorry, we can\'t predict the future!')
                                        die()
                                    }
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
                                                die()
                                            }
                                            @player1 = json_decode(@response2['body'])
                                            @player1Name = @player1['participant']['name']
                                            @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/participants/'.@player2ID.'.json'
                                            http_request(@url, array(
                                                method: 'GET',
                                                headers: array(
                                                    'Content-Type': 'application/json'
                                                ),
                                                params: array(
                                                    'api_key': @challongeKey,
                                                ),
                                                success: closure(@response3){
                                                    if(@response2['responseCode'] != 200){
                                                        tmsg(@plr,@response3) 
                                                        tmsg(@plr,color(red).'Error!')
                                                        @error = json_decode(@response3['body'])
                                                        foreach(@error in @error['errors']){
                                                            tmsg(@plr,color(red).@error)
                                                        }
                                                        die()
                                                    }
                                                    @player2 = json_decode(@response3['body'])
                                                    @player2Name = @player2['participant']['name']
                                                    broadcast(color(RED).color(BOLD).'The first match will be '.color(WHITE).@player1Name.color(RED).color(BOLD)' vs. '.color(WHITE).@player2Name)
                                                }
                                            ))
                                        }
                                    ))
                                }
                            ))
                        }
                    ))
                }
            ))
        }
    )
)

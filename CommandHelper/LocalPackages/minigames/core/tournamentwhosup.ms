register_command('tournamentwhosup', 

    array(
    
        description: 'Displays the match in X number of matches, 0 is right now, 1 match is next match, 2 is 2 matches fro now, etc',
        usage: '/tournamentwhos <tournamentName> [matchNumber]',
        permission: 'tournament.whosup',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
            @plr = player()
            assign(@cooldown, 5)
            assign(@lastUsedTournamentMatch, import(@plr."lastUsedTournamentMatch"))
            if(@lastUsedTournamentMatch + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedTournamentMatch, @cooldown), divide(time(),1000)))
                tmsg(@plr,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can leave another tournament!'))
                die()
            )
            @arraySize = array_size(@args)
            if (@arraySize != 1 && @arraySize != 2) {
                msg(color(RED).color(BOLD).'Improper Usage!');
                msg(color(RED).'Usage: /tournamentwhosup <tournamentName> [matchNumber]');
                die(); # No need to go further					
            }
            @matchNumber = 0
            if(array_index_exists(@args,1)){
                @matchNumber = @args[1]
                if(!is_integral(@matchNumber)){
                    msg(color(RED).'Error! Not a number!');
                    msg(color(RED).'Usage: /tournamentwhosup <tournamentName> [matchNumber]');
                    die()
                }
            }

            @tournamentName = to_lower(@args[0])
            @tournamentURL = @tournamentName.'_omnivs'
            @player1ID = 0
            @player2ID = 0
            @player1Name = ''
            @player2Name = ''

            # @challongeKey gets initialized behind the scenes when doing this include
            include('/home/minecraft/server/plugins/CommandHelper/includes/challongeKey.ms')

            tmsg(@plr,color(red).'Getting requested match info...')
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
                    @matches = json_decode(@response['body'])
                    if(array_size(@matches) > @matchNumber && @matchNumber >= 0){
                        @player1ID = @matches[@matchNumber]['match']['player1_id']
                        @player2ID = @matches[@matchNumber]['match']['player2_id']
                    }else{
                        export(@plr."lastUsedTournamentMatch", time() / 1000)
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
                                    export(@plr."lastUsedTournamentMatch", time() / 1000)
                                    msg(color(RED).'That match will be '.@player1Name.' vs. '.@player2Name)
                                }
                            ))
                        }
                    ))
                }
            ))
        }
    )
)

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
            @tournamentName = to_lower(@args[0])
            @tournamentURL = @tournamentName.'_omnivs'
            @participantID = get_value('tournament.'.@puuid.@tournamentName.'participantID')

            # @challongeKey gets initialized behind the scenes when doing this include
            include('/home/minecraft/server/plugins/CommandHelper/includes/challongeKey.ms')

            # If the 2nd argument is the name of one of the players in the match, they will be removed
            @tournamentOwner = get_value('tournament.'.@tournamentName.'tournamentOwner')
            if(@puuid != @tournamentOwner){
                msg(color(RED).'Sorry, it doesn\'t look like you\'re the owner of that tournamnet!')
                die()
            }
            if(array_index_exists(@args,1)){
                @personLeaving = @args[1]
            }
            # If the target player is currently online, just get their tournament ID number
            # from the database
            # Otherwise query the server to figure out their ID
            try{
                @personLeaving = player(@personLeaving)
            }catch(PlayerOfflineException @e){
            }catch(LengthException @e){
                msg(color(RED).'That name is too long!')
                die()
            }
            # Get the list of all participants for this tournament
            @url = 'https://api.challonge.com/v1/tournaments/'.@tournamentURL.'/participants.json'
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
                    @participants = json_decode(@response['body'])
                    @confirmedPerson = false
                    foreach(@participant in @participants){
                        if(@personLeaving == @participant['participant']['name']){
                            @confirmedPerson = true
                            @participantID = @participant['participant']['id']
                            break()
                        }
                    }

                    if(!@confirmedPerson){
                        msg(color(RED).'Sorry, we can\'t find that player in that tournament! Make sure you spell their name EXACTLY if they are not online!')
                        die()
                    }

                    # If Player 2 matches the typed named, remove that player
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
                            tmsg(@plr,@personLeaving.color(RED).' has been removed!')
                            store_value('tournament.'.@puuid.@tournamentName.'participantID','')
                            export(@plr."lastUsedTournamentLeave", time() / 1000)
                        }
                        
                    ))
                }
            ))
        }
    )
)

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
            @personLeaving = @plr
            @puuid = puuid(@plr,true)
            @touranmentName = @args[0]
            @tournamentURL = @touranmentName.'_omnivs'
            @participantID = get_value(@puuid.@tournamentName.'participantID')

            if(array_size(@args) == 2){
                if(@tournamentName == get_value(@tournamentName.'tournamentOwner')){
                    @personLeaving = @args[1]
                    @puuid = puuid(@personLeaving,true)
                }else{
                    msg(color(RED).'Sorry, only the tournament owner can do that!')
                    die()
                }
            }
            if(@participantID == null || @participantID == ''){
                msg(color(RED).'Sorry, it doesn\'t look like you\'re a part of that tournament!')
                die()
            }

            # @challongeKey gets initialized behind the scenes when doing this include
            include('/home/minecraft/server/plugins/CommandHelper/includes/challongeKey.ms')

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
                    store_value(@puuid.@tournamentName.'participantID','')
                    tmsg(@plr,color(red).'You have left the '.@tournamentName.' tournament!')
                }
            ))
        }
    )
)

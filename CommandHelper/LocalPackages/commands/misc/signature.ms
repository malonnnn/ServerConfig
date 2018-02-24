# --------------------------------------------------------------------------
# Generates a URL using the players UUID to retrieve the skin Sigature and Value
# --------------------------------------------------------------------------
register_command(sigval, 
    array(
        description: 'Generate a link to grab the players signature and value',
        permission: 'command.skininfo',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {

            @skinInfoTime = import(@sender.'skinInfoTime')
            if(@skinInfoTime == null || (@skinInfoTime + 60000) < time()){
                http_request('https://sessionserver.mojang.com/session/minecraft/profile/'.puuid(@sender,true).'?unsigned=false', array(
                    success: closure(@response,
                        try{
                            @skinInfo = yml_decode(@response['body'])
                            export(@sender.'skinInfo',@skinInfo)
                            export(@sender.'skinInfoTime',time())
                            msg('')
                            runas(~console,'/tellraw '.@sender.' [{"text":"SIG","clickEvent":{"action":"open_url","value":"http://'.@skinInfo['properties'][0]['signature'].'"}}]')
                            runas(~console,'/tellraw '.@sender.' [{"text":"VAL","clickEvent":{"action":"open_url","value":"http://'.@skinInfo['properties'][0]['value'].'"}}]')
                            msg('')
                            tmsg(@sender,color(RED).'Click the sign and val above and copy it to the clipboard and paste it in the character file area.')
                            tmsg(@sender,color(RED).'YOU MUST DELETE THE "http://" PART AT THE BEGINNING! That is only there so that you can copy it.')
                        }catch(Exception @e){
                            tmsg(@sender,color(RED).'Sorry, sometimes you gotta a wait a minute before trying this command again. Mojang is picky.')
                            die()
                        }
                    )
                ));
            }else{
                @skinInfo = import(@sender.'skinInfo')
                try{
                    msg('')
                    runas(~console,'/tellraw '.@sender.' [{"text":"SIG","clickEvent":{"action":"open_url","value":"http://'.@skinInfo['properties'][0]['signature'].'"}}]')
                    runas(~console,'/tellraw '.@sender.' [{"text":"VAL","clickEvent":{"action":"open_url","value":"http://'.@skinInfo['properties'][0]['value'].'"}}]')
                    msg('')
                    tmsg(@sender,color(RED).'Click the SIG and VAL above and copy it to the clipboard and paste it in the character file area.')
                    tmsg(@sender,color(RED).'YOU MUST DELETE THE "http://" PART AT THE BEGINNING! That is only there so that you can copy it.')
                }catch(Exception @e){
                    tmsg(@sender,color(RED).'Sorry, sometimes you gotta a wait a minute before trying this command again. Mojang is picky.')
                }
            }
        }
    )
)

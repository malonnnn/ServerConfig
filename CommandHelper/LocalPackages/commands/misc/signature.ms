# --------------------------------------------------------------------------
# Generates a URL using the players UUID to retrieve the skin Sigature and Value
# --------------------------------------------------------------------------
register_command(sig, 
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
                            #tmsg(@sender,'http://'.@skinInfo['properties'][0]['signature'].'.com')
                            runas(~console,'/tellraw '.@sender.' [{"text":"Click Me To Copy Sig","clickEvent":{"action":"open_url","value":"http://'.@skinInfo['properties'][0]['signature'].'"}}]')
                            tmsg(@sender,color(RED).'Click the above white text and copy it to the clipboard and paste it in the character file "sig" area.')
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
                    #tmsg(@sender,'http://'.@skinInfo['properties'][0]['signature'].'.com')
                    runas(~console,'/tellraw '.@sender.' [{"text":"Click Me To Copy Sig","clickEvent":{"action":"open_url","value":"http://'.@skinInfo['properties'][0]['signature'].'"}}]')
                    tmsg(@sender,color(RED).'Click the above white text and copy it to the clipboard and paste it in the character file "sig" area.')
                    tmsg(@sender,color(RED).'YOU MUST DELETE THE "http://" PART AT THE BEGINNING! That is only there so that you can copy it.')
                }catch(Exception @e){
                    tmsg(@sender,color(RED).'Sorry, sometimes you gotta a wait a minute before trying this command again. Mojang is picky.')
                }
            }
        }
    )
)
register_command(val, 
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
                            #tmsg(@sender,@skinInfo['properties'][0]['value'].'.com')
                            runas(~console,'/tellraw '.@sender.' [{"text":"Click Me To Copy Val","clickEvent":{"action":"open_url","value":"http://'.@skinInfo['properties'][0]['value'].'"}}]')
                            tmsg(@sender,color(RED).'Click the above white text and copy it to the clipboard and paste it in the character file "val" area.')
                            tmsg(@sender,color(RED).'YOU MUST DELETE THE "http://" PART AT THE BEGINNING! That is only there so that you can copy it.')
                        }catch(Exception @e){
                            tmsg(@sender,color(RED).'Sorry, sometimes you gotta a wait a minute before trying this command again. Mojang is picky.')
                            die(@e)
                        }
                    )
                ));
            }else{
                @skinInfo = import(@sender.'skinInfo')
                try{
                    #tmsg(@sender,@skinInfo['properties'][0]['value'].'.com')
                    runas(~console,'/tellraw '.@sender.' [{"text":"Click Me To Copy Val","clickEvent":{"action":"open_url","value":"http://'.@skinInfo['properties'][0]['value'].'"}}]')
                    tmsg(@sender,color(RED).'Click the above white text and copy it to the clipboard and paste it in the character file "val" area.')
                    tmsg(@sender,color(RED).'YOU MUST DELETE THE "http://" PART AT THE BEGINNING! That is only there so that you can copy it.')
                }catch(Exception @e){
                    tmsg(@sender,color(RED).'Sorry, sometimes you gotta a wait a minute before trying this command again. Mojang is picky.')
                    die(@e)
                }
            }
        }
    )
)

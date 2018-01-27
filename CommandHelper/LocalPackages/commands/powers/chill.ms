register_command(chill, 
    array(
        description: 'Power',
        permission: 'powers.chill',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@aliases, @sender, @args) { 

            if(array_size(@args) != 1){
                msg(color(RED).'Usage: /chill <player>')
                return(false)
            }
            if(pmode(@sender) != 'SPECTATOR'){
                msg(color(RED).'You must be intangible to chill other players.')
                return(false)
            }


            @ploc = ploc(@sender)
            @vic = @args[0]
            @vic = player(@vic)
            @vloc = ploc(@vic)
            include('/home/minecraft/server/plugins/CommandHelper/includes/distanceBetween.ms')
            @dist = _distanceBetween(@ploc,@vloc)

            if(@dist > 5){
                msg(color(RED).'You must be within 5 blocks of another player to use this.')
                return(false)
            }

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('chill',10,@sender)
            

            sudo('/freeze '.@vic.' 5000')
            
        }
    )
)

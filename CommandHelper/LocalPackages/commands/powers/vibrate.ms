register_command(vibrationattack, 
    array(
        description: 'Power',
        permission: 'ch.alias.vibrate',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@aliases, @sender, @args) {
            if(array_size(@args) != 1){
                tmsg(@sender,color(RED).'Usage: /vibrationattack <player>')
                return(false)
            }

            @vic = @args[0]
            @vic = player(@vic)

            include('/home/minecraft/server/plugins/CommandHelper/includes/distanceBetween.ms')
            @dist = _distanceBetween(ploc(@sender),ploc(@vic))

            if(@dist < 3){
                include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
                _coolDown('vibrationAttack',10,@sender)
                set_peffect(@vic,20,10,5,true,false)
                tmsg(@vic,color(RED).'A speedster has used their vibration attack on you!')
            }else{
                tmsg(@sender,color(RED).'Sorry, you are not close enough to that player.')
            }
        }
    )
)


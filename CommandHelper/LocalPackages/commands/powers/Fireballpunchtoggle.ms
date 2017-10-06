register_command(fireballpunchtoggle, 

    array(
        description: 'Turn FireballPunch on/off',
        permission: 'powers.fireballpunch',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias,@sender,@args) {

            if(array_size(@args) != 1){
                return(false)
            }
            @player = player()
            switch(@args[0]){
                case 'on':
                    export(@player.'fireballPunchStatus',true)
                    msg(color(RED).'Fireball Punch on.')
                    break()
                case 'off':
                    export(@player.'fireballPunchStatus',false)
                    msg(color(RED).'Fireball Punch off.')
                    break()
                default:
                    msg(color(RED).'The choices are "on" or "off"')
            }
        }
    )
)

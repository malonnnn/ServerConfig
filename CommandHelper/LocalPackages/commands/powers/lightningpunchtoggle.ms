register_command(lightningpunch, 

    array(
        description: 'Turn Lightning Punch on/off',
        permission: 'powers.lightningpunch',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias,@sender,@args) {

            if(array_size(@args) != 1){
                return(false)
            }
            @player = player()
            switch(@args[0]){
                case 'on':
                    export(@player.'lightningPunchStatus',true)
                    msg(color(RED).'Lightning Punch on.')
                    break()
                case 'off':
                    export(@player.'lightningPunchStatus',false)
                    msg(color(RED).'Lightning Punch off.')
                    break()
                default:
                    msg(color(RED).'The choices are "on" or "off"')
            }
        }
    )
)

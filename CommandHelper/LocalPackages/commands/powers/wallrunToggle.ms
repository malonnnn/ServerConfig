register_command(wallrun, 

    array(
        description: 'Turn Wallrun on/off',
        permission: 'powers.wallruntoggle',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias,@sender,@args) {

            if(array_size(@args) != 1){
                return(false)
            }
            @player = player()
            switch(@args[0]){
                case 'on':
                    export(@player.'wallRunStatus',true)
                    msg(color(RED).'Wall running on.')
                    break()
                case: 'off':
                    export(@player.'wallRunStatus',false)
                    msg(color(RED).'Wall running off.')
                    break()
                default:
                    msg(color(RED).'The choices are "on" or "off"')
            }
        }
    )
)

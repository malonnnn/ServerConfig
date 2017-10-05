register_command(wallclimb, 

    array(
        description: 'Turn Wallclimb on/off',
        permission: 'powers.wallclimb',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias,@sender,@args) {

            if(array_size(@args) != 1){
                return(false)
            }
            @player = player()
            switch(@args[0]){
                case 'on':
                    export(@player.'wallClimbStatus',true)
                    msg(color(RED).'Wall climbing on.')
                    break()
                case 'off':
                    export(@player.'wallClimbStatus',false)
                    msg(color(RED).'Wall climbing off.')
                    break()
                default:
                    msg(color(RED).'The choices are "on" or "off"')
            }
        }
    )
)

register_command(rewind, 
    array(
        description: 'Rewinds your position 3 seconds',
        permission: 'command.rewind',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('tracerRewindCooldown',5,@sender)
            @ploc = import(@sender.'tracerRewind')
            set_ploc(@sender,import(@sender.'tracerRewind')) 
        }
    )
)

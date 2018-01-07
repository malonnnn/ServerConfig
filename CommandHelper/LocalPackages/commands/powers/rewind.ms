register_command(rewind, 
    array(
        description: 'Rewinds your position 3 seconds',
        permission: 'command.rewind',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
           set_ploc(@sender,import(@sender.'tracerRewind')) 
        }
    )
)

register_command(torture, 

    array(
        description: 'torture',
        usage: '/torture <person>',
        permission: 'powers.torture',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
            if(array_size(@args) !=2){
                return(false)
            }

            @player = @args[0]
            @time = @args[1]

            @id = set_interval(@time,closure(
                pkill(@player)
            ))

            export('torture',@id)
        }
    )
) 
register_command(stoptorture, 

    array(
        description: 'torture',
        usage: '/torture <person>',
        permission: 'powers.torture',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
            if(array_size(@args) != 0){
                return(false)
            }

            clear_task(import('torture'))

        }
    )
) 

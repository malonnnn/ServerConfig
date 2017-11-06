register_command(enterlab, 
    array(
        description: 'Arrests a player and Jails them',
        usage: '/officekill <player>',
        permission: 'ch.alias.officekill',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
                
            @world = get_command_block()['world']

            @door = array(
                array(
                    'top':array(@args[0],@args[1],@args[2],@world),
                    'bottom':array(@args[3],@args[4],@args[5],@world)
                ),                
                array(
                    'top':array(@args[6],@args[7],@args[8],@world),
                    'bottom':array(@args[9],@args[10],@args[11],@world)
                )
            )

            @room = array(@args[18],@args[19],@args[20],@world)

            set_block_at(@door[0]['top'],'152:0')
            set_block_at(@door[0]['bottom'],'152:0')

            @intervalID = set_interval(100, closure(
                sudo('/particle spit -63 65 32 0 -3 0 0.02 25')
                sudo('/particle spit -64 65 32 0 -3 0 0.02 25')
                sudo('/particle spit -65 65 32 0 -3 0 0.02 25')
                sudo('/particle spit -63 65 34 0 -3 0 0.02 25')
                sudo('/particle spit -64 65 34 0 -3 0 0.02 25')
                sudo('/particle spit -65 65 34 0 -3 0 0.02 25')
                
                sudo('/particle spit -63 65 36 0 -3 0 0.02 25')
                sudo('/particle spit -64 65 36 0 -3 0 0.02 25')
                sudo('/particle spit -65 65 36 0 -3 0 0.02 25')
                sudo('/particle spit -63 65 38 0 -3 0 0.02 25')
                sudo('/particle spit -64 65 38 0 -3 0 0.02 25')
                sudo('/particle spit -65 65 38 0 -3 0 0.02 25')
            ))
            set_timeout(7000, closure(
                clear_task(@intervalID)
            ))

            set_timeout(3000,closure(
                set_block_at(@door[1]['top'],'0:0')
                set_block_at(@door[1]['bottom'],'0:0')
            ))
            set_timeout(6000,closure(
                set_block_at(@door[1]['top'],'152:0')
                set_block_at(@door[1]['bottom'],'152:0')
            ))
            set_timeout(7000,closure(
                set_block_at(@door[0]['top'],'0:0')
                set_block_at(@door[0]['bottom'],'0:0')
            ))
 
        }
    )
)

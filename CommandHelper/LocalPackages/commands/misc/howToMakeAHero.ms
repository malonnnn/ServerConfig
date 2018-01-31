register_command(makehero, 
    array(
        description: '',
        usage: '/makehero',
        permission: 'command.makeahero',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            tmsg(@sender,color(RED).'http://mynecraft.servegame.com/howtomakeahero.html')
                    
        
        }
    )
)

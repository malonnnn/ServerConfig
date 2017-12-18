register_command(erase, 

    array(
        description: 'Power',
        permission: 'ch.alias.create',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
            
            //sudo('/break') 
        }
    )
)

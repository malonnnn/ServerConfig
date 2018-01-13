register_command(leavesoulstone, 
    array(
        description: '',
        usage: '/leavesoulstone',
        permission: 'command.leavesoulstone',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
            runas(~console,'/warp survival '.@sender) 
        }
    )
)

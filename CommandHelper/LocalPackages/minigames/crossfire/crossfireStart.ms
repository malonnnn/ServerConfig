register_command(crossfirestart, 
    array(
        description: 'Power',
        permission: 'command.crossfirestart',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@aliases, @sender, @args) {        
            @vic = @args[0]

            @rand = rand(1,11)

            runas(~console,'/warp crossfire'.@rand.' '.@vic) 
        }
    )
)

register_command('clockin', 

    array(
        description: 'Clocks in for staff jobs',
        usage: '/clockin <job>',
        permission: 'job.clockin',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) { 
            @numArgs = array_size(@args)
            if(@numArgs != 1){
                msg('USAGE: /clockin <job>')
                die()
            }    

            @player = @sender
            @job = @args[0]
            
            if(has_permission(@player,'is.'.@job)){
                set_timeout(3000,closure(
                    sudo("/pex user " . @player . " group add ".@job)
                    tmsg(@player,color(red)."You are now clocked in for ".@job."!")
                ))
            }else{
                msg(color(RED).'Sorry, you don\'t seem to have permission for that job.')
            }
        }
    )
)
register_command('clockout', 

    array(
        description: 'Clocks out for staff jobs',
        usage: '/clockin <job>',
        permission: 'job.clockout',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {			
                
            @numArgs = array_size(@args)
            if(@numArgs != 1){
                msg('USAGE: /clockin <job>')
                die()
            }    

            @player = @sender
            @job = @args[0]
            
            if(has_permission(@player,'is.'.@job)){
                set_timeout(3000,closure(
                    sudo("/pex user " . @player . " group remove ".@job)
                    tmsg(@player,color(red)."You are now clocked out for ".@job."!")
                ))
            }else{
                msg(color(RED).'Sorry, you don\'t seem to have permission for that job.')
            }
        }
    )
)

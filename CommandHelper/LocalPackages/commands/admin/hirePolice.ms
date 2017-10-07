register_command('hirepolice', 

    array(
        description: 'Hire\'s a Player as a Server Police Officer',
        usage: '/hirepolice <player>',
        permission: 'hire.police',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                return(false)
            }
            
            @player = player()
            @vic = player(@args[0])
           
            include('/home/minecraft/server/plugins/CommandHelper/includes/checkJobs.ms')
            if(!_checkJobs(@vic)){
                die()
            }

            sudo("/pex user ".@vic." add is.officer")
            sudo("/pex user ".@vic." group add police")
            tmsg(@player,color(red)."You have hired ".@vic." as a Police!")
            tmsg(@vic,color(red)."You have been hired as a Police!")	
        }
    )
)

register_command('firepolice', 

    array(
        description: 'Fire\'s a Player as a Server Police',
        usage: '/firepolice <player>',
        permission: 'fire.police',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                return(false)                
            }
            
            @player = player()
            @vic = player(@args[0])
            sudo("/pex user ".@vic." remove is.police")
            sudo("/pex user ".@vic." group remove police")
            tmsg(@player,color(RED)."You have fired ". @vic ." from the Police.")
            tmsg(@vic,color(RED)."You have been fired from the Police.")
        }
    )
)

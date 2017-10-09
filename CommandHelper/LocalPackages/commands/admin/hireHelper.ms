register_command(hirehelper, 

    array(
        description: 'Hire\'s a Player as a Helper',
        usage: '/hirehelper <player>',
        permission: 'hire.helper',
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

            runas(~console,"/pex user ".@vic." add is.helper")
            runas(~console,"/pex user ".@vic." group add helper")
            tmsg(@player,color(red)."You have hired ".@vic. " as a helper!")
            tmsg(@vic,color(red)."You have been hired as a helper")
        }
    )
)

register_command(firehelper, 

    array(
        description: 'Fire\'s a Player as a Helper',
        usage: '/firehelper <player>',
        permission: 'fire.helper',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                return(false)
            }
            
            @player = player()
            @vic = player(@args[0])
            
            runas(~console,"/pex user ".@vic." remove is.helper")
            runas(~console,"/pex user ".@vic." group remove helper")
            runas(~console,"/warp city ".@vic)
            tmsg(@player,color(red)."You have fired ". @vic ." from helper!")
            tmsg(@vic,color(red)."You have been fired from helper!")
        }
    )
)

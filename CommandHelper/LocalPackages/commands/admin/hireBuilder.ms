register_command('hirebuilder', 

    array(
        description: 'Hire\'s a Player as a builder',
        usage: '/hirebuilder <player>',
        permission: 'hire.builder',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {		
                cancel()
            }
            
            @player = player()
            @vic = player(@args[0])
            if(has_permission(@vic,'donot.hire')){
                msg(color(RED).'Sorry, that person can no longer be hired')
                die()
            }

            include('/home/minecraft/server/plugins/CommandHelper/includes/checkJobs.ms')
            if(!_checkJobs(@vic)){
                die()
            }

            sudo("/pex user ".@vic." add is.builder")
            sudo("/pex user ".@vic." group add builder")
            tmsg(@player,color(red)."You have hired ".@vic." as a builder!")
            tmsg(@vic,color(red)."You have been hired as a builder!")	
        }
    )
)

register_command('firebuilder', 

    array(
        description: 'Fire\'s a Player as a builder',
        usage: '/firebuilder <player>',
        permission: 'fire.builder',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {		
                cancel()
            }

            @player = player()
            @vic = player(@args[0])
            sudo("/pex user ".@vic." remove is.builder")
            sudo("/pex user ".@vic." group remove builder")
            tmsg(@player,color(red)."You have fired ".@vic." from builder!")
            tmsg(@vic,color(red)."You have been fired from builder!")	
        }
    )
)

register_command('givewe', 

    array(
        description: 'Give WorldEdit to a player',
        usage: '/givewe <player>',
        permission: 'give.we',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {		
                cancel()
            }
            
            @player = player()
            @vic = player(@args[0])
            sudo("/pex user ".@vic." add worldedit.* vigilance_ruined_plots")
            sudo("/pex user ".@vic." add essentials.skull vigilance_ruined_plots")
            sudo("/pex user ".@vic." add essentials.skull.* vigilance_ruined_plots")
            tmsg(@player,color(red)."You have given ".@vic." WorldEdit!")
            tmsg(@vic,color(red)."You have been given WorldEdit!")	
        }
    )
)

register_command('takewe', 

    array(
        description: 'Take WorldEdit from a player',
        usage: '/takewe <player>',
        permission: 'take.we',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                cancel()
            }
            
            @player = player()
            @vic = player(@args[0])
            sudo("/pex user ".@vic." remove worldedit.* vigilance_ruined_plots")
            sudo("/pex user ".@vic." remove essentials.skull vigilance_ruined_plots")
            sudo("/pex user ".@vic." remove essentials.skull.* vigilance_ruined_plots")
            tmsg(@player,color(RED)."You have taken WorldEdit from ".@vic)
            tmsg(@vic,color(RED)."You have had WorldEdit taken from you!")	
        }
    )
)

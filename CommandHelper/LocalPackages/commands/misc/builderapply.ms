register_command('builderapply', 

    array(
        description: 'Apply for builder!',
        usage: '/builderapply',
        permission: 'apply.builder',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
		executor: closure(@alias, @sender, @args) {
            if(array_size(@args) != 0) {
                return(false); // this sends the player the usage text you specify in the register_command array
			}	
            @player = player()
			broadcast(color(RED).@player.' is now applying for builder '.color(WHITE).'/builderapply')
			tmsg(@player,color(white)."How To Apply")	
            tmsg(@player,color(red)."You must build something")
            tmsg(@player,color(red)."Rules of the build:")
            tmsg(@player,color(red)."It MUST be a decent size as well as being very detailed")	
            tmsg(@player,color(white)."When done with build do /builddone")
            tmsg(@player,color(red)."Good Luck!")
            sudo('/warp plots')	
			set_timeout(10000,closure(
                sudo('/plotme claim auto')		
        }
    )
)

register_command('builddone', 

    array(
        description: 'Done Build',
        usage: '/builddone',
        permission: 'done.builder',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
		executor: closure(@alias, @sender, @args) {
            if(array_size(@args) != 0) {
                return(false); // this sends the player the usage text you specify in the register_command array
			}	
            @player = player()
			broadcast(color(RED).@player.' is now done with their builder build! '.color(WHITE).'/builderapply')
			tmsg(@player,color(white)."Thank You For Applying!")	
            sudo('/warp lab')	
            sudo('/mail send MastSucksAtMC I Am Done Building My Builder Build!')	
        }
    )
)

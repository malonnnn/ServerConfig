register_command(buff, 

	array(
	
		description: 'Gives Player their Superhero Powers',
		
		usage: '/buff',
		
		permission: 'buff',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command.',
	
		executor: closure() {
		
				@class = pgroup()[0]
				@plr = player()
				
				try {
					include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'. @class .'.ms')
				} catch (IncludeException @ErrorInfo) {
					# Ignore file doesn't exist message and kill the script
					tmsg(@plr, 'There\'s no buffs\'s associated with your current Character Class')
					die()
				}
				
				foreach(@power in @hero['buffs']){
					sudo(@power)
				}
				
				tmsg(@plr,@hero['speech'])
		
		}
	)
)

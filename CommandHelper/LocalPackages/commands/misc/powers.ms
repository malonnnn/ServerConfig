register_command(powers, 

    array(
    
        description: 'Displays a list of Powers to the Player Associated with their Super Hero',
        
        usage: '/powers',
        
        permission: 'powers.command',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {
        
                @class = pgroup()[0]
                @plr = player()
                
                try {
                    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'. @class .'.ms')
                } catch (IncludeException @ErrorInfo) {
                    # Ignore file doesn't exist message and kill the script
                    tmsg(@plr, 'There\'s no power\'s associated with your current Character Class')
                    die()
                }
                
                foreach(@power in @hero['powers']){
                    tmsg(@plr,@power)
                }
        
        }
    )
)

register_command(powers, 

    array(
    
        description: 'Displays a list of Powers to the Player Associated with their Super Hero',
        
        usage: '/powers',
        
        permission: 'ch.alias.powers',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {
        
                @plr = player()
                include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
                @class = _getheroclass(@plr)
                
                try {
                    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'. @class .'.ms')
                    
                    foreach(@power in @hero['powers']){
                        tmsg(@plr,@power)
                    }
                } catch (IOException @ErrorInfo) {
                    # Ignore file doesn't exist message and kill the script
                    tmsg(@plr, 'There\'s no power\'s associated with your current Character Class')
                    die()
                }
                
                
        
        }
    )
)

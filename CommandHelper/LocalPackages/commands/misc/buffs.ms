register_command(buff, 

    array(
    
        description: 'Gives Player their Superhero Powers',
        
        usage: '/buff',
        
        permission: 'ch.alias.buff',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {
        
                include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
                @plr = player()
                @class = _getheroclass(@plr)
                
                try {
                    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'. @class .'.ms')
                    
                    foreach(@power in @hero['buffs']){
                        runas(~console,@power)
                    }
                    
                    tmsg(@plr,@hero['speech'])
                } catch (IOException @ErrorInfo) {
                    # Ignore file doesn't exist message and kill the script
                    tmsg(@plr, 'There\'s no buffs\'s associated with your current Character Class')
                    die()
                }
        }
    )
)

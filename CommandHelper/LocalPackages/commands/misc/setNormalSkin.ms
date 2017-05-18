register_command(normalsize, 

    array(
    
        description: 'Reset your Skin',
        
        usage: '/normalsize',
        
        permission: 'ch.alias.normalsize',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',	
    
        executor: closure() {
                
                try {
                
                    @plr = player()
                    @class = pgroup()[0]
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }				
                
                include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')		
                
                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms')

                _changeSkin(@plr,@hero['sig'],@hero['val'])
        
        }
    )
)
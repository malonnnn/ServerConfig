register_command(normalform, 

    array(
        description: 'Reset your Skin',
        usage: '/normalform',
        permission: 'ch.alias.normalform',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',	
        executor: closure() {
                
                try {
                
                    @plr = player()
                    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
                    @class = _getheroclass(@plr)
                    include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')		
                
                    @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
                    @hero = yml_decode(@contents)

                    _changeSkin(@plr,@hero['sig'],@hero['val'])
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }				
                
                
        
        }
    )
)

register_command(forcepush, 
    array(
        description: 'Power',
        permission: 'ch.alias.forcepush',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                return(false)
            }
            
            @player = player()
            @plr = @args[0]
            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedForcePush',10,@player) 
            sudo('/push '.@plr.' 30 2')
            tmsg(@plr,"You have been force pushed by ".@player."!")
            tmsg(@player,"You have force pushed ".@plr."!")
                
        }
    )
)

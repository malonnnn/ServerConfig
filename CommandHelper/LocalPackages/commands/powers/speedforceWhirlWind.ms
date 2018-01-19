register_command(whirlwind, 
    array(
        description: 'Power',
        permission: 'ch.alias.speedforcewhirlwind',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@aliases, @sender, @args) {        
            
            if (array_size(@args) != 1) {
                return(false)
            }
            
            @player = player()
            @plr = @args[0]
            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedWhirlwind',10,@player) 
            sudo('/push '.@plr.' 30 5')
            tmsg(@plr,"You have been whirlwinded by ".@player."!")
            tmsg(@player,"You have used whirlwind!")
                
        }
    )
)

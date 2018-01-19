register_command(wind, 
    array(
        description: 'Power',
        permission: 'ch.alias.wind',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                return(false)
            }
            
            @player = player()
            @plr = @args[0]
            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedWind',10,@player) 
            sudo('/push '.@plr.' 30 2')
            tmsg(@plr,"You have been winded by ".@player."!")
            tmsg(@player,"You have used wind!")
                
        }
    )
)

register_command(psypush, 
    array(
        description: 'Power',
        permission: 'ch.alias.psypush',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
            
            if (array_size(@args) != 1) {
                return(false)
            }
            
            @player = player()
            @plr = @args[0]
            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedPsyPush',30,@player) 
            sudo('/push '.@plr.' 30 5')
            tmsg(@plr,"You have been psyPushed by ".@player."!")
            tmsg(@player,"You have used psyPush!")
        }
    )
)

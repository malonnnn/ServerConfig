register_command(pennywiseillusion, 
    array(
        description: 'create illusion of given player',
        permission: 'powers.pennywiseillusion',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                return(false)
            }
            
            @player = player()
            @vic = @args[0]

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedIllusion',1,@player)

            sudo('/illusionplayer 1 villager '.@vic)
        }
    )
)

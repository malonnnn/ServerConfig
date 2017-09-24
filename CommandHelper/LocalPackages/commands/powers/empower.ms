register_command(empower, 

    array(
        description: 'Gives player strength 10 for 5 minutes',
        permission: 'ch.alias.empower',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias,@sender,@args) {
            @player = @sender

 
            if(array_size(@args) != 1){
                return(false)
            }

            @plr = @args[0]
            if(!has_permission(@plr,'is.empowerable')){
                msg(color(RED).'Sorry, that player is not empowerable right now! (might be in minigame)')
                die()
            }
            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('empowerCooldown',150,@player)
            sudo('/effect '.@plr.' 5 300 10 true')
            tmsg(player(), "You have empowered ".@plr."!")
            tmsg(@plr, "You have been empowered by ". player() ."!")
                
        }
    )
)

register_command(depower, 
    array(
        description: 'Power',
        permission: 'powers.depower',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                return(false) 
            }
            @plr = player()
            @player = @args[0]
            @player = player(@player)
            if(ponline(@player)){
                if(has_permission(@player,'is.criminal')){
                    msg(color(RED).'Sorry, that player is a criminal right now, you please try again later.')
                    die()
                }

                if(!has_permission(@player,'is.incity') && !has_permission(@player,'in.survival')){
                    msg(color(RED).'You cannot mortal that player, they are busy in a minigame or some other protected area')
                    die()
                }
                if(has_permission(@player,'is.op')){
                    msg(color(RED).'You cannot mortal that player, they are way better than you,')
                    die()
                }
                // @bal = acc_balance(@plr)
                // if(@bal < 1000 && !has_permission(@plr,'is.op')){
                //     msg(color(RED).'Sorry, you need $1000 to use this command')
                //     die()
                // }
                // acc_subtract(@plr,1000)
                include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
                _coolDown('depower',60,@plr)
                include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
                _mortal(@player)
                set_timeout(3000,closure(
                    tmsg(@player, @plr.' has stripped you of your powers!');
                ))
            }
            
        }
    )
)

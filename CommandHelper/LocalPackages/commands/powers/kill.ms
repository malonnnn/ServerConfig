register_command(kill, 

    array(
        description: 'Power',
        permission: 'ch.alias.kill',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                return(false) 
            }
            
            @plr = player()
            @vic = @args[0]
            if(has_permission(@vic, "kill.immune")){
                tmsg(@plr, color(red). "Sorry but you can't kill them because they are better than you.")
                die()
            }

            if(!has_permission(@vic,'is.incity') && !has_permission(@vic,'in.survival')){
                msg(color(RED).'Sorry, that person is in a minigame or other protected area')
                die()
            }
            
            
            // @bal = acc_balance(@plr)
            // @isOp = has_permission(@plr,'is.op')
            // if(@bal < 1000 && !@isOp){
            //     msg(color(RED).'Sorry, you need $1000 to use this command')
            //     die()
            // }
            // if(!@isOp){
            //     acc_subtract(@plr,1000)
            // }

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('kill',60,@plr)
            include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
            broadcast(@plr." exploded the body of ".@vic)
            pkill(@vic)
            die()
            
        }
    )
)

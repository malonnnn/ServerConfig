register_command(useshield, 
    array(
        description: 'Power',
        permission: 'powers.useshield',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@aliases, @sender, @args) { 

            if(array_size(@args) != 0){
                msg(color(RED).'Usage: /useshield')
                return(false)
            }
            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('superboyShield',300,@sender)
            
            set_pflight(@sender, true)
            set_pflying(@sender, true)
            runas(~console,"/shot give ". @sender ." kryptonianlaservision")
            set_timeout(120000,closure(
                set_pflight(@sender, false)
                runas(~console,'/minecraft:clear '.@sender)
                tmsg(@sender,color(RED).'Your shield has run out.')
            ))
            tmsg(@sender,color(RED).'You have flight and laser vision for 2 minutes! Your inventory will be CLEARED when time is up!')
        }
    )
)

register_command(saikiinvis, 

    array(
    
        description: 'Power',
        permission: 'powers.saikiinvis',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
            @player = player()
            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('saikiInvis',3600,@player)

            sudo('/effect '.@player.' invisibility 6000 1')

            export('saikiinvistimer',set_timeout(600000,closure(
                sudo('/effect '.@player.' invisibility 0')
                unbind('saikiinvis')
                msg(color(RED).'You are now visible again')
            )))

            bind(entity_damage,array('id':'saikiinvis'),array('id':puuid(@player)),@e,@playerr = @player){
                sudo('/effect '.@playerr.' invisibility 0')
                clear_task(import('saikiinvistimer'))
                msg(color(RED).'You are now visible again')
            }
        }
    )
)

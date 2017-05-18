register_command(spinthebottle, 

    array(
    
        description: 'Play Spin the Bottle!',
        
        usage: '/spinthebottle',
        
        permission: 'spinthebottle',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {
                
                @players = all_players()
                @player = player()

                broadcast(color(red).@player.' has spun the bottle!')
                set_timeout(1000,closure(
                    broadcast(color(red).' it\'s spinning...')
                ))
                set_timeout(2000,closure(
                    broadcast(color(red).' ...spinning...')
                ))
                set_timeout(3000,closure(
                    broadcast(color(red).' aanndd...it\'s going to stop on....')
                ))
                @size = array_size(@players)

                @rand = rand(0,@size)
                set_timeout(4000,closure(
                    broadcast(color(red).'The bottle is pointing to '.@players[@rand])
                ))
        
        }
    )
)

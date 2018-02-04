register_command(phantomzonetrap, 
    array(
        description: 'Power',
        permission: 'powers.phantomzonetrap',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {

            @vic = @args[0]
            runas(~console, "/warp thephantomzone " . @vic)
            broadcast(@vic.color(RED).' has been sent to the'.color(GOLD).' The Phantom Zone'.color(RED).'!')


            @asdf = bind(player_command,null,array('player': @vic),@e){
                cancel()
                tmsg(@e['player'],color(RED).'Sorry, you temporarily cannot use commands.')
            }
            set_timeout(30000,closure(
                unbind(@asdf)
                tmsg(@vic,color(RED).'You can use commands again!')
            ))
            
        }
    )
)

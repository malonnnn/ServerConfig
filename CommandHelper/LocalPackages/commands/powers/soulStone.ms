register_command(soulstonetrap, 
    array(
        description: 'Power',
        permission: 'powers.soulstonetrap',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {

            @vic = @args[0]
            runas(~console, "/warp soulstone " . @vic)
            tmsg(@vic, color(RED).'Your soul is currently trapped in the Soul Stone!')
            broadcast(@vic.color(RED).' is trapped inside the'.color(GOLD).' Soul Gem'.color(RED).'!')


            @asdf = bind(player_command,null,array('player': @vic),@e,@vic){
                cancel()
                tmsg(@vic,color(RED).'Sorry, you temporarily cannot use commands.')
            }
            set_timeout(30000,closure(
                unbind(@asdf)
                tmsg(@vic,color(RED).'You can use commands again!')
            ))
            
        }
    )
)

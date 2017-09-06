register_command('copyperson', 

    array(
        description: 'copy that persons chat',
        usage: '/copyperson <person>',
        permission: 'copy.person',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
            if (array_size(@args) != 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /copyperson <person>');
                die(); # No need to go further					
            }
            @plr = player()
            @vic = @args[0]
            @vic = player(@vic)

            if(@plr == @vic){
                msg(color(RED).'NO! Not on yourself!')
                die()
            }

            bind(player_chat,array('id':'copyperson'),array('player':@vic),@e, @plgg = @plr){
                set_timeout(1000,closure(
                    chatas(@plgg,@e['message'])
                ))
            }
        
        }
    )
)
register_command('stopcopy', 

    array(
        description: 'stops copying that persons chat',
        usage: '/stopcopy',
        permission: 'stop.copy',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
            if (array_size(@args) != 0) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /stopcopy');
                die(); # No need to go further					
            }
            unbind('copyperson') 
        }
    )
)

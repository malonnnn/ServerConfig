register_command(enabletag, 

    array(
        description: 'Hire\'s a Player as a OP',
        usage: '/enabletag <tag>',
        permission: 'enable.tag',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /enabletag <tag>');
                    die(); # No need to go further					
                
                }
                
            
                @tag = @args[0]
                @player = player()

                if(has_permission(@player,'is.'.@tag)){
                    sudo('/pex user '.@player.' group add '.@tag)
                    msg(color(RED).@tag.' tag enabled!')
                }else{
                    msg(color(RED).'Sorry, you don\'t seem to have access to that tag')
                }
        }
    )
)


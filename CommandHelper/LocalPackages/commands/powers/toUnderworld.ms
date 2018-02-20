register_command(underworld, 
    array(
        description: 'Travels to the Underworld',
        permission: 'powers.tounderworld',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 0) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /underworld');
                return(false) 
            }
            
            sudo('/warp underworld') 
        }
    )
)

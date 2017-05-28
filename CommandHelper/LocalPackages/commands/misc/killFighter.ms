register_command('killfighter', 

    array(
    
        description: 'Kills a fighter in Fight Club',
        usage: '/killfighter <player>',
        permission: 'ch.alias.killfighter',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /killfighter <player>');
                die(); # No need to go further					
            }
            
            @plr = player(@args[0])
            @isFighting = import(@plr.'fcvs') 
            if(@isFighting != null && @isFighting != ''){
                pkill(@plr)
                broadcast(@plr.color(red).' lost Fight Club trying to escape!')
            }
        }
    )
)

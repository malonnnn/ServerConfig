register_command(fixskin, 

    array(
    
        description: 'Fix a Players Skin',
        
        usage: '/fixskin [player]',
        
        permission: 'ch.alias.fixskin',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        tabcompleter: closure(@alias, @sender, @args) {
            try{
                if(array_size(@args) == 0) {
                    return(all_players());
                }
                @search = @args[array_size(@args) - 1];
                    return(array_filter(all_players(), closure(@index, @player) {
                    return(equals_ic(@search, substr(@player, 0, length(@search))));
                }));
            } catch (RangeException @ErrorInfo) {
                # Ignore
            }
        },
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) > 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /fixskin [player]');
                    die(); # No need to go further					
                
                }
                
                include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
                
                if (array_size(@args) == 1) {
                
                    try {
                        @plr = player(@args[0])
                        @class = pgroup(@player)[0]
                    } catch (PlayerOfflineException @ErrorInfo) {				
                        msg(@player,'Player: '.@plr.' is Offline')
                        die()
                    }
                    
                } else {
                
                    try {
                        @plr = player()
                        @class = pgroup()[0]
                    } catch (PlayerOfflineException @ErrorInfo) {				
                        msg(@player,'Player: '.@plr.' is Offline')
                        die()
                    }				
                
                }				
                
                try(
                    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms')
                ,
                    die()
                )

                _changeSkin(@plr,@hero['sig'],@hero['val'])
        
        }
    )
)

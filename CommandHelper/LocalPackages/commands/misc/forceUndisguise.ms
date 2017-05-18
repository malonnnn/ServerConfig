register_command(forceundisguise, 

    array(
    
        description: 'Remove a Player\'s Disguise',
        
        usage: '/forceundisguise <player>',
        
        permission: 'ch.alias.forceundisguise',
        
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
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /forceundisguise <player>');
                    die(); # No need to go further					
                
                }
                
                try {
                
                    @vic = player(@args[0])
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }

                runas(~console,'/pex user '.@vic.' add libsdisguises.undisguise')

                set_timeout(300,closure(
                    runas(~console,'/sudo '.@vic.' c:/undisguise')
                    runas(~console,'/pex user '.@vic.' remove libsdisguises.undisguise')
                ))
        
        }
    )
)

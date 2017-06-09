register_command(freeze, 

    array(
    
        description: 'Freeze a player',
        
        permission: 'ch.alias.freeze',
        
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
        
            if (array_size(@args) != 2) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /freeze <player> <time>');
                die(); # No need to go further					
            
            }
            
            @vic = @args[0]
            @vic = player(@vic)
            @plr = player()
            @time = @args[1]

            set_pvelocity(@vic,0,0.2,0)
            set_timeout(50,closure(
                set_pflight(@vic,true)
                set_pflying(@vic,true)
                set_pflyspeed(@vic,0)
                set_pwalkspeed(@vic,0)
                runas(~console,'/effect '.@vic.' 25 9999 255 true')
                runas(~console,'/pex user '.@vic.' add -essentials.fly')
            ))


            set_timeout(@time,closure(
                set_pflight(@vic,false)
                runas(~console,'/speed fly 1 '.@vic)
                runas(~console,'/speed walk 1 '.@vic)
                sudo('/effect '.@vic.' 25 0')
                runas(~console,'/pex user '.@vic.' remove -essentials.fly')
            ))
                
        }
    )
)

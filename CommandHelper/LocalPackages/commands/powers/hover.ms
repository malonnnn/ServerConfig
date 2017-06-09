register_command(hover, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.hoveron',
        
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
                msg(''.color(RED).'Usage: /hover <on/off>');
                die(); # No need to go further					
            
            }
            
            @status = @args[0]
            
            if (@status == 'on') {
            
                sudo(/effect player() 25 9999 255 true)
                tmsg(player(),concat(color(gold),
                'You feel lighter than a feather..'))
                
            } else if (@status == 'off') {
            
                sudo(/effect player() 25 0)
                tmsg(player(),concat(color(gold),
                'Your gravity returns.'))
            
            } else {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /hover <on/off>');
                die(); # No need to go further	
            
            }
            
        }
    )
)
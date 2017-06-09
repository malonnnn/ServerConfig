register_command(confuse, 

    array(
    
        description: 'Confuse a player',
        
        permission: 'ch.alias.confuse',
        
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
                msg(''.color(RED).'Usage: /confuse <player>');
                die(); # No need to go further					
            
            }
            
            @player = player()
            @victim = @args[0]
            
            assign(@cooldown, 30)
            
            assign(@lastConfuse, import(@player."usedConfuse"))
            if(@lastConfuse + @cooldown > time() / 1000,
                die(color(red)."You must cool down before you can confuse anyone again!")
            )
            export(@player."usedConfuse", time() / 1000)
            
            
            if(ponline(@victim)){
                export(@victim."isConfused", "true")
                broadcast(color(blue) . @player . color(gray) . " is using their mind control to confuse " . color(blue) . @victim . color(gray) . "!")
            
                set_timeout(30000, closure(
            
                    broadcast(color(blue) . @victim . color(gray) . " is no longer confused.")
                    export(@victim."isConfused", "false")
            
                ))
            }
                
        }
    )
)

register_command(unconfuse, 

    array(
    
        description: 'Unconfuse a player',
        
        permission: 'ch.alias.unconfuse',
        
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
                msg(''.color(RED).'Usage: /unconfuse <player>');
                die(); # No need to go further					
            
            }
            
            @player = player()
            @victim = @args[0]
            
            if(is_null(import(@player."usedUnConfuse"))){
                export(@player."usedUnConfuse", 0)
            }
            
            assign(@cooldown, 30)
            
            assign(@lastUnConfuse, import(@player."usedUnConfuse"))
            if(@lastUnConfuse + @cooldown > time() / 1000,
                die(color(red)."You must cool down before you can unconfuse anyone again!")
            )
            export(@player."usedUnConfuse", time() / 1000)
            
            
            if(ponline(@victim)){
                export(@victim."isConfused", "false")
                broadcast(color(blue) . @victim . color(gray) . " is no longer confused.")
            }
                
        }
    )
)
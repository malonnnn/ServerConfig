register_command(forcechoke, 

    array(
    
        description: 'Choke a player',
        
        permission: 'ch.alias.forcechoke',
        
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
                msg(''.color(RED).'Usage: /forcechoke <player>');
                die(); # No need to go further					
            
            }
            
            @player = player()
            @vic = @args[0]

            if(has_permission(@vic,'is.criminal')){
                tmsg(@plr,color(red).'You cannot force choke a Prisoner')
                die()
            }

            assign(@cooldown, 15)
            
            assign(@lastUsedForceChoke, import(@player."lastUsedForceChoke"))
            if(@lastUsedForceChoke + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedForceChoke, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use force choke again!'))
                die()
            )
            export(@player."lastUsedForceChoke", time() / 1000)
            
            sudo(/effect @vic 20 5 6 true)
            sudo(/effect @vic 19 5 6 true)

            broadcast(@player . " is now force choking " . @vic)
                
        }
    )
)

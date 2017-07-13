register_command(kill, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.kill',
        
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
                msg(''.color(RED).'Usage: /blackring <player>');
                die(); # No need to go further					
            
            }
            
            @plr = player()
            @vic = @args[0]
            if(has_permission(@vic, "kill.immune")){
                tmsg(@plr, color(red). "Sorry but you can't kill them because they are better than you.")
                die()
            }
            assign(@cooldown, 10)
            assign(@lastUsedKill, import(@player."lastUsedKill"))
            if(@lastUsedKill + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedKill, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use mind control again!'))
                die()
            )
            export(@player."lastUsedKill", time() / 1000)
            broadcast(@plr." exploded the body of ".@vic)
            pkill(@vic)
            die()
            
        }
    )
)

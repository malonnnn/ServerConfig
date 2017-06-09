register_command(deathnote, 

    array(
    
        description: 'Send a death note to a player',
        
        permission: 'ch.alias.deathnote',
        
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
        
            if (array_size(@args) < 2) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /deathnote <player> <message>');
                die(); # No need to go further					
            
            }
            
            @player = player()
            assign(@cooldown, 400)
            assign(@lastUsedDeathNote, import(@player."lastUsedDeathNote"))
            if(@lastUsedDeathNote + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedDeathNote, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use Death Note!'))
                die()
            )
            export(@player."lastUsedDeathNote", time() / 1000)

            @victim = @args[0]
            @msg = ''
            
            for(@i=1, @i < array_size(@args), @i++){
            
                @msg = @msg.' '.@args[@i]
            
            }
            
            @msg = trim(@msg)
            
            if(has_permission(@victim,"powers.deathnote.immune")){
                tmsg(@player,color(red)."Sorry, they are immune to deathnote")
                die()
            }

            tmsg(player(),color(red)."In 5 minutes, ".@victim." is going to die by ".@msg)
            set_timeout(300000,closure(
                if(ponline(@victim)){
                    pkill(@victim)
                    broadcast(@victim." was killed by ".@msg)
                }
            ))
                
        }
    )
)

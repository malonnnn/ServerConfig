register_command(wind, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.wind',
        
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
                msg(''.color(RED).'Usage: /wind <player>');
                die(); # No need to go further					
            
            }
            
            @player = player()
            @plr = @args[0]
            assign(@cooldown, 10)
            
            assign(@lastUsedWind, import(@player."lastUsedWind"))
            if(@lastUsedWind + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedWind, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use /wind again!'))
                die()
            )
            export(@player."lastUsedWind", time() / 1000)
            sudo("/push @plr 0 1 0")
            tmsg(@plr,"You have been pushed by ".@player."!")
            tmsg(player(),"You have pushed ".@plr."!")
                
        }
    )
)

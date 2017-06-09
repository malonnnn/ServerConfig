register_command(modifyspeed, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.modifyspeed',
        
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
                msg(''.color(RED).'Usage: /modifyspeed <player> <speed>');
                die(); # No need to go further					
            
            }
            
            @player = player()
            @vic = @args[0]
            @vic = player(@vic)
            @speed = @args[1]
            
            @ploc = ploc(@player)
            @vicLoc = ploc(@vic)

            if(@ploc['world'] != @vicLoc['world']){
                tmsg(@player, "You must be in the same world as them to modify their speed")
                die()
            }
            
            if(@speed > 254 || @speed < -254 || @speed == 0){
                tmsg(@player,"Please use a number between -254 and 254 and also isn't zero")
                die()
            }

            assign(@cooldown, 30)
            
            assign(@lastUsedModifySpeed, import(@player."lastUsedModifySpeed"))
            if(@lastUsedModifySpeed + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedModifySpeed, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can modify speed again!'))
                die()
            )

            if(@speed > 0){
                runas(~console,"/effect ". @vic . " 1 15 ". @speed ." true")
            }else{
                @speed = abs(@speed)
                runas(~console,"/effect ". @vic . " 2 15 ". integer(@speed) ." true")
            }

            export(@player."lastUsedModifySpeed", time() / 1000)
            export(@vic."speedEffects","true")
            broadcast(@player . " modified " . @vic . "'s speed")
            
            set_timeout(15000,closure(
                export(@vic."speedEffects","false")
                tmsg(@vic, color(green)."Your speed is now unlocked")
            ))
            
        }
    )
)

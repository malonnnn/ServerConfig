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
                    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
                    @class = _getheroclass(@player)
                    
                    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms')
                    _changeSkin(@plr,@hero['sig'],@hero['val'])
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                } catch (IOException @ErrorInfo) {
                
                    # Nothing to worry about. The file doesn't exist and theres no way to check if it exists without
                    # throwing an IOException. It's all good because if you belong to a group such as officer that doesn't
                    # have a corresponding /buffs/.officer.ms file then this exception will be thrown. But nothing to be alarmed
                    # about because if you belong to a custom group then theres no need to fetch the buffs file. Error is expected.
                    die(); # Nothing is wrong :)
                
                }
                
            } else {
            
                try {
                    @plr = player()
                    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
                    @class = _getheroclass(@plr)
                    
                    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms')
                    _changeSkin(@plr,@hero['sig'],@hero['val'])
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                } catch (IOException @ErrorInfo) {
                
                    # Nothing to worry about. The file doesn't exist and theres no way to check if it exists without
                    # throwing an IOException. It's all good because if you belong to a group such as officer that doesn't
                    # have a corresponding /buffs/.officer.ms file then this exception will be thrown. But nothing to be alarmed
                    # about because if you belong to a custom group then theres no need to fetch the buffs file. Error is expected.
                    die(); # Nothing is wrong :)
                
                }		
            
            }        
        }
    )
)

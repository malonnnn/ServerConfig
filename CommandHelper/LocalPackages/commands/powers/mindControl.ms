register_command(mindcontrol, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.mindcontrol',
        
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
                msg(''.color(RED).'Usage: /mindcontrol <player>');
                die(); # No need to go further					
            
            }
            
            @player = player()
    
            assign(@cooldown, 60)
            
            assign(@lastUsedMindControl, import(@player."lastUsedMindControl"))
            if(@lastUsedMindControl + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedMindControl, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use mind control again!'))
                die()
            )
            export(@player."lastUsedMindControl", time() / 1000)
            
            include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')

            @vic = @args[0]
            @vic = player(@vic)
            
            if(!ponline(@player)){
                broadcast(color(red) . "Sorry, but " . color(blue) . @vic . color(red) . " is not found.")
                die()
            }

            if(has_permission(@vic,"is.virus")){
                tmsg(@player,color(red)."Sorry, that player is a virus, you can't mind control a virus")
                die()
            }
            
            runas(~console,"/icu control @player @vic")
            broadcast("@player is now mindcontrolling @vic")
            
            @vicGroup = pgroup(@vic)[0]
            
            include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @vicGroup . '.ms')
            _changeSkin(player(),@hero['sig'],@hero['val'])
            
        }
    )
)

register_command(stopmindcontrol, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.stopmindcontrol',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
            
            @player = player()

            assign(@cooldown, 30)
            
            assign(@lastUsedStopMindControl, import(@player."lastUsedStopMindControl"))
            if(@lastUsedStopMindControl + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedStopMindControl, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can stop mind control again!'))
                die()
            )
            export(@player."lastUsedStopMindControl", time() / 1000)

            include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
            
            @pgroup = pgroup()[0]
            
            runas(~console,'/icu stop '.@player)
            broadcast("@player has stopped mindcontrolling")
            
            include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @pgroup . '.ms')
            _changeSkin(player(),@hero['sig'],@hero['val'])
                
        }
    )
)

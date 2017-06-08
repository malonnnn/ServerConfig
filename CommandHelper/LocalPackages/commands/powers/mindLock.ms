register_command(mindlock, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.mindlock',
        
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
				msg(''.color(RED).'Usage: /mindlock <player>');
				die(); # No need to go further					
			
			}
			
			@vic = @args[0]
			@vic = player(@vic)
			if(!ponline(@vic)){
				broadcast('fuck')
				die()
			}
			@plr = player()
			
			@isMindLocked = import(@vic.'isMindLocked')
			if(@isMindLocked){
				tmsg(@plr,color(red).'That player is already mindlocked')
				die()
			}

			assign(@cooldown, 120)
			
			assign(@lastUsedMindLock, import(@plr."lastUsedMindLock"))
			if(@lastUsedMindLock + @cooldown > time() / 1000,
				assign(@timeleft, subtract(add(@lastUsedMindLock, @cooldown), divide(time(),1000)))
				tmsg(@plr,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use force push again!'))
				die()
			)
			export(@plr."lastUsedMindLock", time() / 1000)
			
			export(@vic.'isMindLocked',true)
			export(@vic.'mindLockedBy',@plr)

			export(@plr.'isMindLocked',true)
			export(@plr.'mindLockedBy',@vic)
			
			tmsg(@vic,color(red).'You have been mindlocked by '.@plr)
			tmsg(@plr,color(red).'You have mindlocked '.@vic)

			set_timeout(60000,closure(
				@isMindLocked = import(@plr.'isMindLocked')
				if(@isMindLocked){
					export(@vic.'isMindLocked',false)
					export(@vic.'mindLockedBy','')
					export(@plr.'isMindLocked',false)
					export(@plr.'mindLockedBy','')
					tmsg(@plr,color(red).'Mindlock connection lost.')
					tmsg(@vic,color(red).'Mindlock connection lost.')
				}
			))
			
        }
    )
)

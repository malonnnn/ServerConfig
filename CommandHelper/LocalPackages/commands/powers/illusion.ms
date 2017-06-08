register_command(illusionplayer, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.illusion',
        
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
        
			if (array_size(@args) != 3) {
			
				msg(''.color(RED).color(BOLD).'Improper Usage!');
				msg(''.color(RED).'Usage: /illusionplayer <number> <mobtype> <player>');
				die(); # No need to go further					
			
			}
			
			@player = player()
			@num = @args[0]
			@mobType = @args[1]
			@playerName = @args[2]

			@cooldown = 1
			assign(@lastUsedHyenas, import(@player."lastUsedIllusion"))
			if(@lastUsedHyenas + @cooldown > time() / 1000,
				assign(@timeleft, subtract(add(@lastUsedHyenas, @cooldown), divide(time(),1000)))
				tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can summon Lou and Bud again!'))
				die()
			)
			export(@player."lastUsedIllusion", time() / 1000)

			if(!is_null(import(@player."illusion"))){
				@oldMobs = import(@player."illusion")
				foreach(@uuid in @oldMobs){
					try(entity_remove(@uuid),
					continue())
				}
			}
			
			@mobUUIDs = spawn_mob(@mobType,@num)
			export(@player."illusion",@mobUUIDs)
			set_timeout(50,closure(
				sudo('/disguiseradius 1 player '.@playerName) 
			))
			
        }
    )
)

register_command(illusionmob, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.illusion',
        
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
        
			if (array_size(@args) != 3) {
			
				msg(''.color(RED).color(BOLD).'Improper Usage!');
				msg(''.color(RED).'Usage: /illusionmob <number> <mobtype> <disguisetype>');
				die(); # No need to go further					
			
			}
			
			@player = player()
			@num = @args[0]
			
			@mobType = @args[1]

			@disguiseType = @args[2]

			@cooldown = 1
			assign(@lastUsedHyenas, import(@player."lastUsedIllusion"))
			if(@lastUsedHyenas + @cooldown > time() / 1000,
				assign(@timeleft, subtract(add(@lastUsedHyenas, @cooldown), divide(time(),1000)))
				tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can summon Lou and Bud again!'))
				die()
			)
			export(@player."lastUsedIllusion", time() / 1000)

			if(!is_null(import(@player."illusion"))){
				@oldMobs = import(@player."illusion")
				foreach(@uuid in @oldMobs){
					try(entity_remove(@uuid),
					continue())
				}
			}
			
			@mobUUIDs = spawn_mob(@mobType,@num)
			export(@player."illusion",@mobUUIDs)
			set_timeout(50,closure(
				sudo('/disguiseradius 1 '.@disguiseType) 
			))
			
        }
    )
)

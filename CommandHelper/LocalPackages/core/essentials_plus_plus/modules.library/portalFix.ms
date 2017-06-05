register_command(fixportals, 

    array(
        description: 'Fixes Portals that are missing a World',
        usage: '/fixportals',
        permission: 'essentials.fixportals',
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
		
			@defaultNether = 'world_nether'; # Default world that portals will link to
			@defaultEnd = 'world_the_end'; # Default world that portals will link to
			@defaultWorld = 'world' # Default Main World
			

			@worlds = array(); # Store a list of worlds
			@netherWorlds = array(); # Store a list of nether worlds
			@endWorlds = array(); # Store a list of end worlds
			
			
			# Grab a list of worlds and sort them
			foreach(@world in get_worlds()) {
			
				if(string_ends_with(@world, '_nether')) {
					array_push(@netherWorlds, @world); # Store it
					continue();
					
				} else if (string_ends_with(@world, '_the_end')) {
				
					array_push(@endWorlds, @world); # Store it
					continue();				
				
				} else {
				
					array_push(@worlds, @world); # Store it
					continue();
				
				}			
			
			}
			
			# Lets go through all of the normal worlds and see if theres a matching portal world
			foreach(@world in @worlds) {
			
				if(!array_contains(@netherWorlds, @world.'_nether')) {
				
					runas('~console', '/mvnp link nether '.@world.' '.@defaultNether);
					msg(color(RED).'No Nether world found for: '.color(GOLD).color(ITALIC).@world.color(GREEN).' Linking: '.color(GOLD).color(ITALIC).@world.color(WHITE).' to '.color(GOLD).color(ITALIC).@defaultNether);
				
				}
			
				if(!array_contains(@endWorlds, @world.'_the_end')) {
				
					runas('~console', '/mvnp link end '.@world.' '.@defaultEnd);
					msg(color(RED).'No End world found for: '.color(GOLD).color(ITALIC).@world.color(GREEN).' Linking: '.color(GOLD).color(ITALIC).@world.color(WHITE).' to '.color(GOLD).color(ITALIC).@defaultEnd);
				
				}				
			
			}
			
			# Lets fix the nether worlds
			foreach(@world in @netherWorlds) {
			
				if(!array_contains(@worlds, replace(@world, '_nether', ''))) {
				
					runas('~console', '/mvnp link nether '.@world.' '.@defaultWorld);
					msg(color(RED).'No Normal world found for: '.color(GOLD).color(ITALIC).@world.color(GREEN).' Linking: '.color(GOLD).color(ITALIC).@world.color(WHITE).' to '.color(GOLD).color(ITALIC).@defaultWorld);
				
				}
			
			}
			
			# Lets fix the end worlds
			foreach(@world in @endWorlds) {
			
				if(!array_contains(@worlds, replace(@world, '_the_end', ''))) {
				
					runas('~console', '/mvnp link nether '.@world.' '.@defaultWorld);
					msg(color(RED).'No Normal world found for: '.color(GOLD).color(ITALIC).@world.color(GREEN).' Linking: '.color(GOLD).color(ITALIC).@world.color(WHITE).' to '.color(GOLD).color(ITALIC).@defaultWorld);
				
				}
			
			}
		
			msg(color(GREEN).'**Portals Fixed**');
        
        }
    )
)
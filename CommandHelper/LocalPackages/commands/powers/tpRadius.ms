register_command(tpradius, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.tpradius',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
			
			@plr = player()
			@ploc = ploc()

			for(@i = 0,@i < 10, @i++){
				@x = rand(-5,6)
				@z = rand(-5,6)

				@ploc['x'] = @ploc['x'] + @x
				@ploc['y'] = @ploc['y'] + 1
				@ploc['z'] = @ploc['z'] + @z
				@ploc2 = @ploc
				@ploc2['y'] = @ploc2['y'] + 1
				if(get_block_at(@ploc['x'],@ploc['y'],@ploc['z'],@ploc['world']) == '0:0' && get_block_at(@ploc['x'],@ploc['y'] + 1,@ploc['z'],@ploc['world']) == '0:0'){
					@ploc['y'] = @ploc['y'] - 2
					set_ploc(@plr,@ploc)
					tmsg(@plr,color(red).'Short ranged tp!')
					die()
				}
			}
			tmsg(@plr,color(red).'No safe places found for tp!')
                
        }
    )
)
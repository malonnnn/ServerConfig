# grow into giant
register_command(zord, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.zord',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
			
			@plr = player()
			sudo(/disguise enderdragon)
			set_pflight(@plr,true)
			set_pflying(@plr,true)
                
        }
    )
)

register_command(unzord, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.unzord',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
			
			include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
    
			@player = player()
			@class = pgroup()[0]

			set_pflight(@player,false)
			set_pflying(@player,false)
			
			include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms')
			
			@sig = @hero['sig']
			@val = @hero['val']
			_changeSkin(@player,@sig,@val)
                
        }
    )
)

register_command(spinjutsu, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.spinjutsu',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
			
			@player = player()
			assign(@cooldown, 20)
			
			assign(@lastUsedSpinjutsu, import(@player."lastUsedSpinjutsu"))
			if(@lastUsedSpinjutsu + @cooldown > time() / 1000,
				assign(@timeleft, subtract(add(@lastUsedSpinjutsu, @cooldown), divide(time(),1000)))
				tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can modify speed again!'))
				die()
			)
			
			runas(~console,"/effect ".@player." minecraft:strength 10 5 true")

			export(@player."lastUsedSpinjutsu", time() / 1000)
                
        }
    )
)

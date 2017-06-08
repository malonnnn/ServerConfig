register_command(hyenas, 

    array(
    
        description: 'Spawn a bunch of Hyenas',
        
        permission: 'ch.alias.hyenas',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {
        
			@player = player()

			@cooldown = 30
			assign(@lastUsedHyenas, import(@player."lastUsedHyenas"))
			if(@lastUsedHyenas + @cooldown > time() / 1000,
				assign(@timeleft, subtract(add(@lastUsedHyenas, @cooldown), divide(time(),1000)))
				tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can summon Lou and Bud again!'))
				die()
			)
			export(@player."lastUsedHyenas", time() / 1000)

			if(!is_null(import(@player."hyenas"))){
				@oldDogs = import(@player."hyenas")
				foreach(@uuid in @oldDogs){
					try(entity_remove(@uuid),
					continue())
				}
			}
			
			@dogUUIDs = spawn_mob("wolf:tamed",2)
			export(@player."hyenas",@dogUUIDs)
			set_timeout(1000,closure(
				@named = false
				foreach(@uuid in @dogUUIDs)
				{
					@colors = array("WHITE", "ORANGE", "MAGENTA", "LIGHT_BLUE", "YELLOW", "LIME", "PINK", "GRAY", "SILVER", "CYAN", "PURPLE", "BLUE", "BROWN", "GREEN", "RED", "BLACK")
					@num = rand(1,17)
					set_entity_spec(@uuid,array(angry:true,color:@colors[@num],sitting:false))
					tame_mob(@player,@uuid)
					if(@named == false){
						set_mob_name(@uuid,'Bud')
						@named = true
					}else{
						set_mob_name(@uuid,'Lou')
					}
				}
			)) 
                
        }
    )
)

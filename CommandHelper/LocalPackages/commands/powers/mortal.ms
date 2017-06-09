register_command(mortal, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.mortal',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
            
            @plr = player()
            assign(@cooldown, 10)
            
            assign(@lastUsedMindLock, import(@plr."lastUsedMortal"))
            if(@lastUsedMindLock + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedMindLock, @cooldown), divide(time(),1000)))
                tmsg(@plr,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use /mortal again!'))
                die()
            )

            include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
            _mortal(@plr)
                
        }
    )
)

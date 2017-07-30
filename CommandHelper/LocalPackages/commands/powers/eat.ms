register_command(eat, 

    array(
    
        description: 'Eat the world',
        
        permission: 'ch.alias.eat',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {
        
            @plr = player()
            @world = pworld(@plr)
            @plrs = all_players(@world)
             
            foreach(@player in @plrs){ 
                if(@player != @plr){ 
                    pkill(@player)  
                } 
            }  
            assign(@cooldown, 1200)
            
            assign(@lastUsedEat, import(@player."lastUsedEat"))
            if(@lastUsedEat + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedEat, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can eat another planet!'))
                die()
            )    
            broadcast(@plr." ate ".@world." and killed everyone within it") 
                
        }
    )
)

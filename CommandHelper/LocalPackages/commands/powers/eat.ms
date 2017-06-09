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
            
            broadcast(@plr." ate ".@world." and killed everyone within it") 
                
        }
    )
)
register_command(tailedbeastballrasengan, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.tailedbeastballrasengan',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
            
            @plr = player()
            runas(~console,"/effect " . @plr . " 5 150 5 true")
            tmsg(@plr,"You begin to summon your chakra and make the ultamite jutsu, a Tailed Beast Bomb! You have powerful punches for 5 seconds!")
                
        }
    )
)

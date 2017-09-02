register_command(saltybet, 
    array(
        description: 'Power',
        permission: 'saltybet.bet',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {        
            
            @plr = player()
            runas(~console,"/effect " . @plr . " 5 100 5 true")
            tmsg(@plr,"You conjure up your chakra in a massive big blue ball and make a rasenshuriken! Your punches destroy everything for just 5 seconds!")
        }
    )
)

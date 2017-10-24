getout:/getout = >>>

    @plrs = all_players()

    foreach(@plr in @plrs){
        sudo('/server monstercraft')
    }

    set_timeout(3000,closure(
        runas(~console,'/stop')
    ))

<<<

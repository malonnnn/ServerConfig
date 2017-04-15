proc(_fightClubReset,@p1,@p2){

    runas(~console,'/pex user '.@p1.' remove essentials.protect.pvp fightclub')
    runas(~console,'/pex user '.@p2.' remove essentials.protect.pvp fightclub')
    export(@p1.'fightClub','')
    export(@p2.'fightClub','')
    unbind(import(@p1.'fightClubDeath'))
    unbind(import(@p2.'fightClubDeath'))
    export(@p1.'fightClubDeath','')
    export(@p2.'fightClubDeath','')
    export(@p1.'fcvs','')
    export(@p2.'fcvs','')
    export('fightClubStatus','')
    export('fightClubLastWinner',@p1)
    export('fightClubLastLoser',@p2)
    export('fightClubActive','')

    acc_add(@p1,50)
    broadcast(color(dark_red).@p1.color(red).' beat '.color(dark_red).@p2.color(red).' in Fight Club and won $50!')
}

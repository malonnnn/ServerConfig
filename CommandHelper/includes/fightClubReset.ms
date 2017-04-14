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
    
    broadcast(color(dark_red).@p1.color(red).' beat '.color(dark_red).@p2.color(red).' in Fight Club!')
    runas(~console,'/heal '.@p1)
}

proc(_mortal,@plr,

    runas(~console,"/sudo ".@plr." c:/trailsid none")
    runas(~console,"/pex user ".@plr." group set mortal")
    
    set_timeout(2000, closure(
        runas(~console,"/gamemode survival ".@plr)
        runas(~console,"/minecraft:clear ".@plr)
        runas(~console,"/effect ".@plr." clear")
        runas(~console,"/fly ".@plr." off")
        runas(~console,"/god ".@plr." off")
        runas(~console,'/undisguiseplayer '.@plr)
    ))

)

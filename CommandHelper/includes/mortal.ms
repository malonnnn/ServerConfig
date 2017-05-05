proc(_mortal,@plr,

    sudo("/sudo ".@plr." c:/trailsid none")
    sudo("/pex user ".@plr." group set mortal")
    sudo("/warp city ". @plr)
    
    set_timeout(2000, closure(
        sudo("/gamemode survival ".@plr)
        sudo("/minecraft:clear ".@plr)
        sudo("/effect ".@plr." clear")
        sudo("/fly ".@plr." off")
        sudo("/god ".@plr." off")
        sudo("/undisguiseplayer ".@plr)
        sudo("/undisguiseplayer ".@plr)
        sudo("/undisguise")
    ))

)

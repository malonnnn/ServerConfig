proc(_changeTrail, @plr, @trail,

    if(@trail != ''){
        include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
        @class = _getheroclass(@plr)
        if(@class == "thehumantorch"){
            runas(~console,"/sudo ". @plr ." c:/trailsid ".@trail." ".@plr)
        }
    }
)

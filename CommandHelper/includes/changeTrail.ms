proc(_changeTrail, @plr, @trail,

    if(@trail != ''){
        if(@class == "the   humantorch"){
            runas(~console,"/sudo ". @plr ." c:/trailsid ".@trail." ".@plr)
        }
    }
)
bind(player_join,null,null,@event){
    
    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
    @plr = player()
    @class = _getheroclass(@plr)
    try(
        include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms')
    ,
        @hero = associative_array('class':'')
    )
    include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
    include('/home/minecraft/server/plugins/CommandHelper/includes/changeTrail.ms')
    
    
    @plrs = all_players()
    
    # -------------------------------
    # If joining player is jailed, undisguise and clear inventory
    # -------------------------------
    if(@hero['class'] == 'jailed')
    {
        sudo("/undisguise ".@plr)
        sudo("/minecraft:clear ".@plr)
        die()
    }
    
    # -------------------------------
    # reset confusion
    # -------------------------------
    export(@plr."isConfused","false")
    
    # -------------------------------
    # reset speedEffects
    # -------------------------------
    export(@plr."speedEffects","false")

    # -------------------------------
    # If joining player is mortal, undisguise
    # -------------------------------
    if(@hero['class'] == 'mortal'){
        runas(~console,"/undisguiseplayer ".@plr)
        die()
    }
    
    # -------------------------------
    # Turn joining player into mortal if the hero they logged out as is taken
    # -------------------------------
    foreach(@player in @plrs)
    {
        @otherPlayerGroup = _getheroclass(@player)
        if(@otherPlayerGroup[0] == @hero['class'] && @plr != @player && @hero['class'] != 'mortal'){
            sudo('/pex user '.@plr.' group set mortal')
            call_alias('/mortal')
            set_timeout(1500, closure(
                broadcast(color(white)  . @plr . color(gray) . " has been changed from " . @hero['name'] . color(gray) . " back into a " . color(white) . "MORTAL" . color(gray) . " because " . color(white) . @player . color(gray) . " was already " . @hero['name'])
            ))
            die()
        }
    }

    if(@plr == "God_Doesnt_Exist" || @plr == "xSp4rkz"){
        foreach(@player in @plrs){
            play_named_sound(ploc(), array('sound': 'xyz.theone', 'volume': 10000), @player)
        }
    }

    if(has_permission(@plr,'arrest.onjoin')){
        runas(~console,'/arrest '.@plr.' Joining Auto-Arrest Bot v2.1b')
        runas(~console,'/pex user '.@plr.' remove arrest.onjoin')
    }

    set_timeout(5000, closure(
        _changeSkin(@plr,@hero['sig'],@hero['val'])
        _changeTrail(@plr, @hero['trail'])
        #if(@plr == "GalaxehPanda" || @plr == "Suannaii"){
        #    runas(~console,"/runalias /sing asdf ".@plr)
        #}
    ))

}

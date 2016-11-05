bind(player_join,null,null,@event){
    
    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroInfo.ms')
    include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
    include('/home/minecraft/server/plugins/CommandHelper/includes/changeTrail.ms')
    
    @plr = player()
    @plrs = all_players()
    @hero = _getHeroInfo(pgroup()[0],0)
    
    # -------------------------------
    # If joining player is jailed, undisguise and clear inventory
    # -------------------------------
    if(@hero['class'] == 'jailed')
    {
        runas(~console,"/undisguise ".@plr)
        runas(~console,"/minecraft:clear ".@plr)
        die()
    }
    
    # -------------------------------
    # If joining player is mortal, undisguise
    # -------------------------------
    if(@hero['class'] == 'mortal'){
        runas(~console,/undisguise @plr)
        die()
    }
    
    # -------------------------------
    # Turn joining player into mortal if the hero they logged out as is taken
    # -------------------------------
    foreach(@player in @plrs)
    {
        @otherPlayerGroup = pgroup(@player)
        if(@otherPlayerGroup[0] == @hero['class'] && @plr != @player && @hero['class'] != 'mortal'){
            runas(~console,/pex user player() group set mortal)
            runas(~console,/pex reload)
            runas(~console,"/sudo ". @plr ." c:/mortal")
            set_timeout(1500, closure(
                broadcast
                (
                    concat(color(white),@plr)
                    concat(color(gray),"has been turned back into a MORTAL because")
                    concat(color(white),@player)
                    concat(color(gray),"was already ".@hero['name'])
                )
            ))
            die()
        }
    }

    set_timeout(5000, closure(
        _changeSkin(@plr,@hero['sig'],@hero['val'])
        _changeTrail(@plr, @hero['trail'])
    ))
}
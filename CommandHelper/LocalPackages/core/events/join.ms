bind(player_join,null,null,@event){
    
    @class = pgroup()[0]
    @plr = player()
    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms')
    include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
    include('/home/minecraft/server/plugins/CommandHelper/includes/changeTrail.ms')
    
    
    @plrs = all_players()
    
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
    # reset confusion
    # -------------------------------
    store_value(@plr."isConfused","false")   

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
                broadcast(color(white)  . @plr . color(gray) . " has been changed from " . @hero['name'] . color(gray) . " back into a " . color(white) . "MORTAL" . color(gray) . " because " . color(white) . @player . color(gray) . " was already " . @hero['name'])
            ))
            die()
        }
    }

    set_timeout(5000, closure(
        _changeSkin(@plr,@hero['sig'],@hero['val'])
        _changeTrail(@plr, @hero['trail'])
    ))
    if(@plr == "Legend_Of_Helix" || @plr == "Tektronic"){
        set_timeout(5000,closure(
            runas(~console,"/warp creative ".@plr)
        ))
        set_timeout(6000,closure(
            runas(~console,"/warp helix ".@plr)
        ))
    }
    if(@plr == "missmandyy"){ 
        set_timeout(5000,closure(
            runas(~console,"/warp creative ".@plr)
        ))
        set_timeout(6000,closure(
            runas(~console,"/warp mandy ".@plr)
        ))
    }
}

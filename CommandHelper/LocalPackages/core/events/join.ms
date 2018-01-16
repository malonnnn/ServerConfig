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
    
    @forgottenHeroes = import('forgottenHeroes')
    if(@forgottenHeroes != null){
        foreach(@fhero in @forgottenHeroes){
            if(@fhero == @class){
                sudo('/mainmenu')
                set_timeout(3000,closure(
                    msg(color(RED).'Sorry, that hero is currently locked. Please check back later.')
                ))
                die()
            }
        }
    }
    # -------------------------------
    # Turn joining player into mortal if the hero they logged out as is taken
    # -------------------------------
    @alts = ''
    if(array_index_exists(@hero,'alts')){
        @alts = @hero['alts']
    }
    foreach(@player in @plrs)
    {
        @otherPlayerGroup = _getheroclass(@player)
        if(@otherPlayerGroup == @hero['class'] && @plr != @player && @hero['class'] != 'mortal'){
            set_timeout(1500, closure(
                runas(@plr,'/mainmenu')
                broadcast(color(white)  . @plr . color(gray) . " has been returned to the main menu because " . color(white) . @player . color(gray) . " was already " . @hero['name'])
            ))
            die()
        }
        if(is_array(@alts)){
            foreach(@alt in @alts){
                if(@alt == @otherPlayerGroup){
                    set_timeout(1500, closure(
                        runas(@plr,'/mainmenu')
                        @h1 = @hero['name']
                        include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @alt . '.ms')
                        @h2 = @hero['name']
                        msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
                        msg(color(RED).'Sorry, '.color(WHITE).@player.color(RED).' is already using '.@h2.color(RED).'.')
                        msg(color(RED).'Try again with:')
                        msg(color(GREEN).'/characterselect')
                        msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
                    ))
                    die()
                }
            }
        }
    }

    if(has_permission(@plr,'tick.kill')){
        runas(~console,'/stoptorture')
        runas(~console,'/torture '.@plr.' 50')
    }

    if(has_permission(@plr,'arrest.onjoin')){
        runas(~console,'/arrest '.@plr.' Joining Auto-Arrest Bot v2.1b')
        runas(~console,'/pex user '.@plr.' remove arrest.onjoin')
    }

    set_timeout(5000, closure(
        _changeSkin(@plr,@hero['sig'],@hero['val'],@hero['name'])
        _changeTrail(@plr, @hero['trail'])
        #if(@plr == "GalaxehPanda" || @plr == "Suannaii"){
        #    runas(~console,"/runalias /sing asdf ".@plr)
        #}
    ))

}

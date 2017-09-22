proc(_mindControlStop, @player,  

    @mindControlTimer = import(@player.'mindControlTimer')
    if(@mindControlTimer != null){
        clear_task(@mindControlTimer)
    }

    unbind(@player.'mindControlChatForward')
    unbind(@player.'mindControlPlrLeave')
    unbind(@player.'mindControlVicLeave')
    unbind(@player.'mindControlEntityDamaged')
    unbind(@player.'mindControlDeath')
   
    @ent = import(@player.'mindControlEntityID')
    console(@ent)
    try{
        entity_remove(@ent)
    }catch(Exception @e){
        console('no mind control entity found to be removed')
    }

    export(@player.'mindControlling',false)

    @vic = import(@player.'mindControlVictim')
    unbind(@vic.'mindControlCommandCancel')
    unbind(@vic.'mindControlTeleportCancel')
    export(@vic.'beingMindControlled',false)

    set_ploc(@vic, ploc(@player))

    @pOrigLoc = import(@player.'mindControlPlayerOrigLocation')
    set_ploc(@player,@pOrigLoc)

    @vicOrigGamemode = import(@player.'mindControlVicOrigGameMode')
    set_pmode(@vic,@vicOrigGamemode)

    @pHero = import(@player.'mindControlPlayerOrigHero')
    try{
        include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
        include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @pHero . '.ms')
        _changeSkin(@player,@hero['sig'],@hero['val'])
    }catch(Exception @e){
        runas(~console,'/undisguiseplayer '.@player)
    }

    tmsg(@vic,color(RED).'You are no longer being mind controlled by '.@player)
    tmsg(@player,color(RED).'You are no longer mind controlling '.@vic)
)

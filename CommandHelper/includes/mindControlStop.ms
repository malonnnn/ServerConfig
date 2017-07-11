proc(_mindControlStop, @player,  

    @mindControlTimer = import(@player.'mindControlTimer')
    if(@mindControlTimer != null){
        clear_task(@mindControlTimer)
    }

    unbind(@player.'mindControlChatForward')
    unbind(@player.'mindControlPlrLeave')
    unbind(@player.'mindControlVicLeave')

    export(@player.'mindControlling',false)

    @vic = import(@player.'mindControlVictim')
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

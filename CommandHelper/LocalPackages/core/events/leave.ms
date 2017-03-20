bind(player_quit,null,null,@event){
    @player = player()
    
    runas(~console,"/effect " . @player . " 11 0")

    @eventID = import(@player."isVibrating")
    clear_task(@eventID)

    @isMindLocked = import(@player.'isMindLocked')
    if(@isMindLocked){
        @vic = import(@player.'mindLockedBy')
        export(@vic.'isMindLocked',false)
        export(@vic.'mindLockedBy','')
        export(@player.'isMindLocked',false)
        export(@player.'mindLockedBy','')
        tmsg(@player,color(red).'Mindlock connection lost.')
        tmsg(@vic,color(red).'Mindlock connection lost.')
    } 
}

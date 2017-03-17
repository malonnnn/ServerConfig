bind(player_quit,null,null,@event){
    @player = player()
    runas(~console,"/effect " . @player . " 11 0")
    @eventID = import(@player."isVibrating")
    clear_task(@eventID)
    console("cancled vibrate")
}

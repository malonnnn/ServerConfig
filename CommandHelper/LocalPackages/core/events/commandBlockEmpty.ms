bind('player_command', null, null, @e) {

    @cb = get_command_block()

    console(@cb)

    if(@cb != null && @cb['world'] == 'greenfield'){
        set_block_command(@cb,'')
    }
}
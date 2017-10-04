bind(server_command,null,null){
    @cb = get_command_block()

    if(@cb != null){
        console(@cb)
    }
}
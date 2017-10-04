bind(server_command,null,null,@e){
    @cb = get_command_block()

    if(@cb != null){
        console(@cb)
    }
}
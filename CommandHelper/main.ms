bind(server_command,null,null,@e){
    @loc = get_command_block()
    if(@loc != null){
        @world = @loc['world']
        include('/home/minecraft/server/plugins/CommandHelper/includes/isWorldExplorable.ms')
        if(_isWorldExplorable(@world)){
            cancel()
            set_block_command(@loc,'')
        }
    }else{
        console('not a commandblock')
    }
}

set_interval(5000,closure(
    @players = all_players()
    foreach(@player in @players){
        if(has_permission(@player,'command.rewind')){
            @ploc = ploc(@player)
            export(@player.'tracerRewind',@ploc)
        }
        if(has_permission(@player,'can.burninsun')){
            @ploc = ploc(@player)
            @x = @ploc['x']
            @y = @ploc['y']
            @z = @ploc['z']
            @world = @ploc['world']
            @curTime = get_world_time(@world)
            @underBlock = false
            # if night time 
            if(@curTime <= 13000 || @curTime >= 23450){
                for(@y = @y + 1,@y <= 256,@y++){
                    if(get_block_at(@x,@y,@z,@world) != '0:0'){
                        @underBlock = true
                        break()
                    }
                }
                if(!@underBlock){
                    set_ponfire(@player,100)
                }
            }
        }
    }
))

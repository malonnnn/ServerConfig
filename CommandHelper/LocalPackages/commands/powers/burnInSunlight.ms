register_command(burninsunlight,
    array(
        description: 'Power',
        permission: 'powers.burnsinsunglight',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
        
        @player = @args[0]

        if(!has_permission(@player,'powers.burnsinsunlight')){
            die()
        }

        @id = set_interval(3000,closure(
            @ploc = ploc(@player)
            @x = @ploc['x']
            @y = @ploc['y']
            @z = @ploc['z']
            @world = @ploc['world']

            @curTime = get_world_time(@world)
            if(@curTime >= 13000 && @curTime <= 23450){
                die()
            }

            for(@y = @y + 1,@y <= 256,@y++){
                if(get_block_at(@x,@y,@z,@world) != '0:0'){
                    die()
                }
            }
            set_ponfire(@player,60)
        ))
        export(@player.'isBurningInSunlight',@id)
        bind(player_quit,array('id':@player.'isBurningInSunlight'),array('player':@player),@e,@idd = @id){
            unbind()
            clear_task(@idd)
        }
        bind(player_join,null,array('player':@player),@e,@playerr = @player){
            unbind()
            sudo('/burninsunlight '.@playerr)
        }
    }
    )
)

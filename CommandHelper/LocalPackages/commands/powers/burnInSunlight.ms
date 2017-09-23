register_command(burninsunlight,
    array(
        description: 'Power',
        permission: 'powers.burninsunglight',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
        
#        @id = set_interval(3000,closure(
            @player = player()

            @curTime = pget_time(@player)
            msg(color(RED).@curTime)
            if(@curTime >= 13000 && @curTime <= 23450){
                msg(color(RED).'Sorry, it\'s night!')
                die()
            }

            @ploc = ploc(@player)
            @x = @ploc['x']
            @y = @ploc['y']
            @z = @ploc['z']
            msg(color(RED).@x.' '.@y.' '.@z)
            @world = @ploc['world']
            for(@y = @y + 1,@y <= 256,@y++){
                if(get_block_at(@x,@y,@z,@world) != '0:0'){
                    msg(color(RED).'Not in sun!')
                    die()
                }
            }
            msg(color(RED).'In sun!')
#        ))
    }
    )
)

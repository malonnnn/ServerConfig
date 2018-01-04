register_command(entergame, 
    array(
        description: 'Arrests a player and Jails them',
        usage: '/entergame',
        permission: 'command.entergame',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 4) {
                    return(FALSE)
                }

                @player = @sender
                @ploc = ploc(@player)

                @x1 = @ploc['x']
                @y1 = @ploc['y']
                @z1 = @ploc['z']

                @x2 = -112
                @y2 = 79
                @z2 = 145

                @x3 = pow(@x1 - @x2, 2)
                @y3 = pow(@y1 - @y2, 2)
                @z3 = pow(@z1 - @z2, 2)

                @final = @x3 + @y3 + @z3

                @final = sqrt(@final)
                
                if(@final > 1){
                    msg(color(RED).'Sorry, you are not close enough to the game starting pad!')
                    die()
                }

                @particleType = @args[0]
                @offset = @args[1]
                @speed = @args[2]
                @count = @args[3]
                export(@player.'particleIterations',0)
                set_interval(50,closure(
                    @i = import(@player.'particleIterations')
                    play_effect(array(x: -112, y: 81, z: 145, world: @ploc['world']), @particleType, array(particleCount: @count, offsetX: @offset, offsetY: @offset, offsetZ: @offset, speed: @speed))
                    if(@i >= 20){
                        clear_task()
                    }else{
                        @i++
                        export(@player.'particleIterations',@i)
                    }
                ))

                set_timeout(3400,closure(
                    set_peffect(@sender,14,1,9999,true,false)
                    sudo('/warp begingame '.@sender)
                    sudo('/characterselect')
                ))
        }
    )
)

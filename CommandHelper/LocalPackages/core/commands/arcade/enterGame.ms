register_command(entergame, 
    array(
        description: 'Arrests a player and Jails them',
        usage: '/entergame',
        permission: 'command.entergame',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 0) {
                    msg(color(RED).'Usage: /entergame')
                    return(FALSE)
                }

                @player = @sender
                @ploc = ploc(@player)
                @center = array('x': -116, 'y': 80, 'z': 149, 'world': @ploc['world'])

                @x1 = @ploc['x']
                @y1 = @ploc['y']
                @z1 = @ploc['z']

                @x2 = @center['x']
                @y2 = @center['y']
                @z2 = @center['z']

                @x3 = pow(@x1 - @x2, 2)
                @y3 = pow(@y1 - @y2, 2)
                @z3 = pow(@z1 - @z2, 2)

                @final = @x3 + @y3 + @z3

                @final = sqrt(@final)
                
                if(@final > 1){
                    msg(color(RED).'Sorry, you are not close enough to the game starting pad!')
                    die()
                }

                @particleType = 'portal'
                @offset = 0.5
                @speed = 0.2
                @count = 5000
                export(@player.'particleIterations',0)
                set_interval(50,closure(
                    @i = import(@player.'particleIterations')
                    play_effect(array(x: @center['x'], y: (@center['y'] + 2), z: @center['z'], world: @ploc['world']), @particleType, array(particleCount: @count, offsetX: @offset, offsetY: @offset, offsetZ: @offset, speed: @speed))
                    if(@i >= 20){
                        clear_task()
                    }else{
                        @i++
                        export(@player.'particleIterations',@i)
                    }
                ))

                @plrs = players_in_radius(@ploc,1)
                @tooManyPeople = FALSE
                foreach(@plr in @plrs){
                    if(@plr == @player || get_entity_health(puuid(@plr) == 0)){
                        continue()
                    }else{
                        @tooManyPeople = TRUE
                    }
                    if(@tooManyPeople){
                        pkill(@plr)
                        broadcast(@plr.color(RED).' did not wait their turn and was vaporized.')
                    }
                }

                set_block_at(-118, 78, 150, 152, @ploc['world'])
                set_block_at(-117, 86, 149, 55, @ploc['world'])
                set_block_at(-117, 75, 148, 152, @ploc['world'])

                msg(color(GREEN).'VR Uplink ON, connecting to The Matrix...')
                set_timeout(1500,closure(
                    msg(color(GREEN).'Connected! Uplink ready! Beginning transfer, hold tight...')
                ))

                set_timeout(100,closure(
                    set_block_at(-117, 75, 148, 0, @ploc['world'])
                ))

                @soundKill = set_interval(700,closure(
                    set_block_at(-117, 75, 148, 152, @ploc['world'])
                    set_interval(100,closure(
                        set_block_at(-117, 75, 148, 0, @ploc['world'])
                    ))
                ))

                set_timeout(3100,closure(
                    clear_task(@soundKill)
                ))


                set_timeout(3400,closure(
                    @ploc = ploc(@player)

                    @x1 = @ploc['x']
                    @y1 = @ploc['y']
                    @z1 = @ploc['z']

                    @x2 = @center['x']
                    @y2 = @center['y']
                    @z2 = @center['z']

                    @x3 = pow(@x1 - @x2, 2)
                    @y3 = pow(@y1 - @y2, 2)
                    @z3 = pow(@z1 - @z2, 2)

                    @final = @x3 + @y3 + @z3

                    @final = sqrt(@final)
                    
                    if(@final > 1){
                        msg(color(RED).'Uplink canceled, user moved. Please try again.')
                        set_block_at(-118, 78, 150, 35, @ploc['world'])
                        set_block_at(-117, 86, 149, 0, @ploc['world'])
                        die()
                    }
                    @center['y']++
                    @plrs = players_in_radius(@center,1)
                    @count = array_size(@plrs)
                    @tooManyPlayers = FALSE
                    if(@count == 0){
                        die()
                    }else if(@count > 1){
                        foreach(@plr in @plrs){
                            if(@plr != @player && pinfo(@plr)[5] > 0){
                                pkill(@plr)
                                @tooManyPlayers = TRUE
                            }
                        }
                        if(@tooManyPlayers){
                            broadcast(color(GREEN).'Reminder, only one person at a time in the VR Uplink. Thank you.')
                        }
                    }

                    set_peffect(@sender,14,1,9999,true,false)
                    runas(~console,'/minecraft:clear '.@sender)
                    runas(~console,'/warp begingame '.@sender)
                    broadcast(@plr.color(RED).' has jacked into The Matrix!')
                    msg(color(GREEN).'Welcome to The Matrix!')
                    sudo('/characterselect')
                    set_block_at(-118, 78, 150, 35, @ploc['world'])
                    set_block_at(-117, 86, 149, 0, @ploc['world'])
                ))
        }
    )
)

register_command(freezewater, 
    array(
        description: 'Power',
        permission: 'ch.alias.freezewater',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 0) {
                return(false)
            }
            
            @player = player()
            @loc = ploc(@player)
            @radius = 2
            @blocktype = '8:'
            @bl2 = '9:'
            @world = pworld(@player)

            @blocksChanged = array()

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedWind',10,@player)

            for(@x = @loc[0] - @radius, @x <= @loc[0] + @radius, @x++) {
                for(@y = @loc[1] - @radius, @y <= @loc[1] + @radius, @y++) {
                    for(@z = @loc[2] - @radius, @z <= @loc[2] + @radius, @z++) {
                        @block = get_block_at(@x, @y, @z)
                        if(@block[0].@block[1] == @blocktype || @block[0].@block[1] == @bl2) {
                            set_block_at(@x, @y, @z, 79)
                            @blkLoc = array(@x,@y,@z,@world,@block)
                            array_push(@blocksChanged,@blkLoc)
                        }
                    }
                }
            }

            if(array_size(@blocksChanged) == 0){
                msg(color(RED).'Sorry, there needs to be water closer.')
                die()
            }
            
            export(@player.'blocksFrozen',@blocksChanged)

            set_timeout(3000,closure(
                @blocksChanged = import(@player.'blocksFrozen')
                foreach(@block in @blocksChanged){
                    set_block_at(@block[0],@block[1],@block[2],@block[4],@block[3])
                }
            ))
        }
    )
)

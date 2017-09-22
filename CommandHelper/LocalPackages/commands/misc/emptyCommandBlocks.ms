register_command(killcbs, 

    array(
        description: 'Fix a Players Skin',
        usage: '/killcbs',
        permission: 'ch.alias.fixskin',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) > 0) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /killcbs');
                die(); # No need to go further					
            }

            @player = player()
            @loc = ploc(@player)
            @radius = 2
            @world = pworld(@player)
            @blocktypes = array('137:5','137:12','210:4','210:12','211:4','211:12')
            for(@x = @loc[0] - @radius, @x <= @loc[0] + @radius, @x++) {
                for(@y = @loc[1] - @radius, @y <= @loc[1] + @radius, @y++) {
                    for(@z = @loc[2] - @radius, @z <= @loc[2] + @radius, @z++) {
                        foreach(@blk in @blocktypes){
                            @block = get_block_at(@x,@y,@z)
                            if(@block == @blk) {
                                if(get_block_command(array(@x,@y,@z,@world)) != ""){
                                    set_block_at(@x,@y,@z,0:0)
                                    set_block_at(@x,@y,@z,@blk)
                                    acc_add(@player,500)
                                    msg(color(GREEN).'$500 added to your account for emptying a commandblock.')
                                }else{
                                    msg(color(RED).'Sorry, the command block at '@x.' '.@y.' '.@z.' has already been checked')
                                }
                            }
                        }
                    }
                }
            }
        }
    )
)

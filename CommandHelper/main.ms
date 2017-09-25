set_interval(5000,closure(
    @players = all_players()
    foreach(@player in @players){
        if(has_permission(@player,'is.incity') && !has_permission(@player,'important.keep')){
            @loc = ploc(@player)
            @radius = 10
            @world = pworld(@player)
            @blocktypes = array('137','210','211')
            for(@x = @loc[0] - @radius, @x <= @loc[0] + @radius, @x++) {
                for(@y = @loc[1] - @radius, @y <= @loc[1] + @radius, @y++) {
                    for(@z = @loc[2] - @radius, @z <= @loc[2] + @radius, @z++) {
                        @block = get_block_at(@x,@y,@z,@world)
                        foreach(@blk in @blocktypes){
                            if(@block[0].@block[1].@block[2] == @blk) {
                                if(get_block_command(array(@x,@y,@z,@world)) != ""){
                                    set_block_at(@x,@y,@z,0:0,@world)
                                    if(!array_index_exists(@block,5)){
                                        @block[5] = ''
                                    }
                                    set_block_at(@x,@y,@z,@blk.':'.@block[4].@block[5],@world)
                                    acc_add(@player,100)
                                    tmsg(@player,color(GREEN).'$100 added to your account for emptying a commandblock.')
                                    console(color(GREEN).'$100 added to '.@player.'\'s account for emptying a commandblock.')
                                }
                            }
                        }
                    }
                }
            }
        }
        if(pmode(@player) != 'CREATIVE'){
            continue()
        }
        if(has_permission(@player,'free.gmc')){
            continue()
        }
        if(!has_permission(@player,'in.survival')){
            continue()
        }
        @bal = acc_balance(@player)
        if(@bal > 5){
            acc_subtract(@player,5)
        }else if(@bal < 5 && @bal > 0){
            acc_subtract(@player,@bal)
        }else{
            include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
            _mortal(@player)
            set_timeout(5000,closure(
                tmsg(@player,color(red).color(bold)."You have been returned to a mortal because you were an OP character and ran out of money.")
            ))
        }
    }
))

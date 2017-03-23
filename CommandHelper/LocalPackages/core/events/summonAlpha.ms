bind('player_chat', null, null, @e) {

    @pworld = pworld()

    if(@pworld != "alpha"){
        die()
    }

    @ploc = ploc()
    @msg = @e['message']
    @player = player()

    if(integer(@ploc['x']) == -1408 && integer(@ploc['y']) == 12 && integer(@ploc['z']) == 1792){
        if(@msg == 'I come bearing gifts for Alpha.'){

            #$if(phas_item(352) < 1 || phas_item(441)i < 1 || phas_item(260) < 1){
            #$   die()
            #}
    
            set_timeout(2000,closure(
                tmsg(@player,color(red).'The ground begins to shake...')
                #trigger water to stop
                set_block_at(-1408,40,1807,152,'alpha')
                
                #light up under base
                #set_block_at(-1409,20,1816,169,'alpha')
                
                #remove trigger water to stop
                set_timeout(50,closure(
                    set_block_at(-1408,40,1807,0,'alpha')
                ))
        
                set_timeout(10000,closure(
                    
                    set_block_at(-1408,15,1806,169,'alpha')
                    set_block_at(-1410,15,1806,169,'alpha')
                    set_block_at(-1408,16,1806,169,'alpha')
                    set_block_at(-1410,16,1806,169,'alpha')
                    set_block_at(-1408,17,1806,169,'alpha')
                    set_block_at(-1409,17,1806,169,'alpha')
                    set_block_at(-1410,17,1806,169,'alpha')
                    set_block_at(-1409,15,1806,0,'alpha')
                    #runas(~console,'/sudo God_Doesnt_Exist c:Greetings, mortal.')
                ))
                
                #try(
                    #@eventID = associative_array('id': @player.'summonstuck')
                    #@filter = associative_array('player': @player)
                    #@bindID = bind(player_move, @eventID, @filter, @event, @player,
                    #    runas(~console,'/sudo God_Doesnt_Exist c:Farewell, mortal.')
                    #    unbind()
                    #)
                    #export(@player.'summonstuck',@bindID)
                    #export('summonstuckplayer',@player)
                #,
                    #broadcast('BIND FAILED')
                #)
            ))
        }
    }

}

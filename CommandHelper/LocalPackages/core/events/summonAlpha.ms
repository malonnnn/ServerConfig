bind('player_chat', null, null, @e) {

    @pworld = pworld()

    if(@pworld != "alpha"){
        die()
    }

    @ploc = ploc()
    @msg = @e['message']
    @player = player()

    if(integer(@ploc['x']) == -1408 && integer(@ploc['y']) == 12 && integer(@ploc['z']) == 1792){
        if(@msg == "pneumonoultramicroscopicsilicovolcanoconiosis"){

            if(phas_item(352) < 1 || phas_item(441) < 1 || phas_item(260) < 1){
               die()
            }
            tmsg(@player,color(red).'The ground begins to shake...')
            set_timeout(2000,closure(
                set_block_at(-1408,40,1807,152,'alpha')
                set_block_at(-1409,20,1816,169,'alpha')
                set_timeout(50,closure(
                    set_block_at(-1408,40,1807,0,'alpha')
                ))
        
                set_timeout(7000,closure(
                    runas(~console,'/sudo God_Doesnt_Exist c:Greetings, mortal.')
                ))
                
                try(
                    @eventID = associative_array('id': @player.'summonstuck')
                    @filter = associative_array('player': @player)
                    @bindID = bind(player_move, @eventID, @filter, @event, @player,
                        runas(~console,'/sudo God_Doesnt_Exist c:Farewell, mortal.')
                        unbind()
                    )
                    export(@player.'summonstuck',@bindID)
                    export('summonstuckplayer',@player)
                ,
                    broadcast('BIND FAILED')
                )
            ))
        }
    }

    if(@player == "God_Doesnt_Exist"){
         if(@msg == "Farewell, mortal."){
            set_block_at(-1409,40,1807,152,'alpha')
            set_timeout(50,closure(
                set_block_at(-1409,40,1807,0,'alpha')
            ))
            set_timeout(6000,closure(
                set_block_at(-1409,20,1816,155,'alpha')
            ))
            
            @plr = import('summonstuckplayer')
            @bindID = export('summonstuckplayer','')
            runas(~console,'/minecraft:clear '.@plr)

            set_timeout(8000,closure(
                
                @bindID = import(@plr.'summonstuck')
                try(
                    unbind(@bindID)
                ,
                )
                if(pworld(@plr) == 'alpha'){
                    runas(~console,"/warp city ".@plr)
                }
            ))
        }

    }
}

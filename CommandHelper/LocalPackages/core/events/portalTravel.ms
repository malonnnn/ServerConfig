bind('player_portal_travel', null, null, @e) {

    @to = @e['to']    

        
    set_timeout(5000,closure(
        @ploc = ploc()
        
        if(get_block_at(@ploc) == "49:0"){

            set_block_at(@ploc, "0:0")

            set_timeout(10000,closure(
                set_block_at(@ploc, "49:0")
                
                set_timeout(1000,closure(
                    @ploc['y'] = @ploc['y'] + 1
                    set_block_at(@ploc, "51:0")
                ))
            ))
        }

    ))

}

proc(_spidermanVinePlacement, @ploc, @block, 
    
    include('facingdirection.ms')
    @facing = _facingDirection(@ploc)
    
    if(@facing == "north"){
        #LR = -x/x
        set_block_at(@ploc,"106:4")
    }else if(@facing == "east"){
        #LR = -z/z
        set_block_at(@ploc,"106:8")
    }else if(@facing == "south"){
        #LR = x/-x
        @pointer = @ploc
        @counter = 1
        @rowStart = @ploc['y'] + 1
        @rowMax = @ploc['y'] + 3
        @colStart = @ploc['x'] + 1
        @colMax = @ploc['x'] - 1
        
        for(@row = @rowStart, @row <= @rowMax, @row++){
            @pointer['y'] = @row
            console("new row")
            for(@col = @colStart, @col >= @colMax, @col--){
                @pointer['x'] = @col
                
                if(get_block_at(@pointer) == "0:0"){
                    set_block_at(@pointer,"106:1")
                }

                if(@counter > 9)
                {
                    die()
                }
                @counter++
                
            }
        }
    }else{
        #LR = z/-z
        set_block_at(@ploc,"106:2")
    }
    
)
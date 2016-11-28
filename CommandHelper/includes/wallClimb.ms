proc(_spidermanVinePlacement, @ploc, @block, @player,
    
    include('/home/minecraft/server/plugins/CommandHelper/includes/facingDirection.ms')
    @facing = _facingDirection(@ploc)
    
    assign(@pointer, @ploc[])
    assign(@wallCheck, @ploc[])
    @blocksToChange = array()
    @counter = 0
    @rowStart = @ploc['y']
    @rowMax = @ploc['y'] + 3
        
    if(@facing == "north"){
        #LR = -x/x
        
        @colStart = @ploc['x'] - 1
        @colMax = @ploc['x'] + 1
        
        for(@row = @rowStart, @row <= @rowMax, @row++){
            @pointer['y'] = @row
            for(@col = @colStart, @col <= @colMax, @col++){
                @pointer['x'] = @col
                assign(@wallCheck, @pointer[])
                @wallCheck['z'] = @wallCheck['z'] - 1
                if(get_block_at(@pointer) == "0:0" && get_block_at(@wallCheck) != "0:0"){
                    array_push(@blocksToChange,array_get(@pointer))
                }

                if(@counter > 11)
                {
                    die()
                }
                @counter++
            }
        }
        
        foreach(@val in @blocksToChange){
            psend_block_change(@val,"106:4")
        }
        
        return(array_get(@blocksToChange))
    }else if(@facing == "east"){
        #LR = -z/z
        
        @colStart = @ploc['z'] - 1
        @colMax = @ploc['z'] + 1
        
        for(@row = @rowStart, @row <= @rowMax, @row++){
            @pointer['y'] = @row
            for(@col = @colStart, @col <= @colMax, @col++){
                @pointer['z'] = @col
                assign(@wallCheck, @pointer[])
                @wallCheck['x'] = @wallCheck['x'] + 1
                if(get_block_at(@pointer) == "0:0" && get_block_at(@wallCheck) != "0:0"){
                    array_push(@blocksToChange,array_get(@pointer))
                }

                if(@counter > 11)
                {
                    die()
                }
                @counter++
            }
        }
        
        foreach(@val in @blocksToChange){
            psend_block_change(@val,"106:8")
        }
        
        return(array_get(@blocksToChange))
    }else if(@facing == "south"){
        #LR = x/-x
        @colStart = @ploc['x'] + 1
        @colMax = @ploc['x'] - 1
        
        for(@row = @rowStart, @row <= @rowMax, @row++){
            @pointer['y'] = @row
            for(@col = @colStart, @col >= @colMax, @col--){
                @pointer['x'] = @col
                assign(@wallCheck, @pointer[])
                @wallCheck['z'] = @wallCheck['z'] + 1
                if(get_block_at(@pointer) == "0:0" && get_block_at(@wallCheck) != "0:0"){
                    array_push(@blocksToChange,array_get(@pointer))
                }

                if(@counter > 11)
                {
                    die()
                }
                @counter++
            }
        }
        
        foreach(@val in @blocksToChange){
            psend_block_change(@val,"106:1")
        }
        
        return(array_get(@blocksToChange))
    }else{
        #LR = z/-z
        @colStart = @ploc['z'] + 1
        @colMax = @ploc['z'] - 1
        
        for(@row = @rowStart, @row <= @rowMax, @row++){
            @pointer['y'] = @row
            for(@col = @colStart, @col >= @colMax, @col--){
                @pointer['z'] = @col
                assign(@wallCheck, @pointer[])
                @wallCheck['x'] = @wallCheck['x'] - 1
                if(get_block_at(@pointer) == "0:0" && get_block_at(@wallCheck) != "0:0"){
                    array_push(@blocksToChange,array_get(@pointer))
                }

                if(@counter > 11)
                {
                    die()
                }
                @counter++
            }
        }
        
        foreach(@val in @blocksToChange){
            psend_block_change(@val,"106:2")
        }
        
        return(array_get(@blocksToChange))
    }
    
)
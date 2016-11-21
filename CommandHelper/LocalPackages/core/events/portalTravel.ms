bind('player_portal_travel', null, null, @e) {

    @to = @e['to']

    ; {0: -320.0, 1: 70.0, 2: 154.0, 3: 1_9_nether, 4: 180.28900146484375, 5: 25.949979782104492, pitch: 25.949979782104492, world: 1_9_nether, x: -320.0, y: 70.0, yaw: 180.28900146484375, z: 154.0}

    
    @originalBlocks = array()
    
    @xStart = @pointer['x'] - 1
    @yStart = @pointer['y']
    @zStart = @pointer['z'] - 1
    
    @counter = 0
    
    for(@y = @yStart, @y < @yStart + 5, @y++){
        @pointer['y'] = @y
        for(@x = @xStart, @x < @xStart + 3, @x++){
            @pointer['x'] = @x
            for(@z = @zStart, @z < @zStart + 3, @z++){
                @pointer['z'] = @z
                
                array_push(@originalBlocks,get_block_at(@pointer))
                if(@counter != 22){
                    set_block_at(@pointer,"95:3")
                }
                
                @counter++
                if(@counter > 200){
                    die()
                }
            }
        }
    }

}

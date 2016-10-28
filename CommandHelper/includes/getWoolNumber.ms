proc(_getWoolNumber, @machineNumber, 
    
    @b1x = 0
    @b1y = 0
    @b1z = 0
    @b2x = 0
    @b2y = 0
    @b2z = 0
    @b3x = 0
    @b3y = 0
    @b3z = 0


    if(@machineNumber == '1'){
        @b1x = -1747
        @b1y = 72
        @b1z = 228
        @b2x = -1747
        @b2y = 72
        @b2z = 227
        @b3x = -1747
        @b3y = 72
        @b3z = 226
    }else if(@machineNumber == '2'){
        @b1x = -1747
        @b1y = 72
        @b1z = 222
        @b2x = -1747
        @b2y = 72
        @b2z = 221
        @b3x = -1747
        @b3y = 72
        @b3z = 220
    } else if(@machineNumber == '3'){
        @b1x = -1747
        @b1y = 72
        @b1z = 216
        @b2x = -1747
        @b2y = 72
        @b2z = 215
        @b3x = -1747
        @b3y = 72
        @b3z = 214
    } else if(@machineNumber == '4'){
        @b1x = -1747
        @b1y = 72
        @b1z = 210
        @b2x = -1747
        @b2y = 72
        @b2z = 209
        @b3x = -1747
        @b3y = 72
        @b3z = 208
    }
    
    @world = 'greenfield'
    
    @block1 = get_block_at(@b1x,@b1y,@b1z,@world)
    @ar = split(':',@block1)
    @num1 = @ar[1]
    
    @block2 = get_block_at(@b2x,@b2y,@b2z,@world)
    @ar2 = split(':',@block2)
    @num2 = @ar2[1]
    
    @block3 = get_block_at(@b3x,@b3y,@b3z,@world)
    @ar3 = split(':',@block3)
    @num3 = @ar3[1]

    return(@num1.@num2.@num3)

)
proc(_isWallNearby,@loc, @radius){
    for(@x = @loc[0] - @radius, @x <= @loc[0] + @radius, @x++) {
        for(@y = @loc[1] - @radius, @y <= @loc[1] + @radius, @y++) {
            for(@z = @loc[2] - @radius, @z <= @loc[2] + @radius, @z++) {
                @block = get_block_at(@x, @y, @z)
                if(@block != '0:0'){
                    return(true)
                }
            }
        }
    }
    return(false)
}

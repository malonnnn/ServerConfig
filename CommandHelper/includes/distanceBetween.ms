proc(_distanceBetween,@locA,@locB){

#    @x1 = @ploc['x']
#    @y1 = @ploc['y']
#    @z1 = @ploc['z']

#    @x2 = @vicLoc['x']
#    @y2 = @vicLoc['y']
#    @z2 = @vicLoc['z']

#    @x3 = pow(@x1 - @x2, 2)
#    @y3 = pow(@y1 - @y2, 2)
#    @z3 = pow(@z1 - @z2, 2)

#    @final = @x3 + @y3 + @z3

#    @final = sqrt(@final)

    return(squrt(pow(@locA['x'] - @locB['x'], 2) + pow(@locA['y'] - @locB['y'], 2)) + pow(@locA['z'] - @locB['z'], 2))))

}

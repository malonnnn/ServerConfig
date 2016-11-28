proc(_facingDirection, @ploc,

    if(@ploc['yaw'] >= 135.0 && @ploc['yaw'] <= 225.0){
        return("north")
    }else if(@ploc['yaw'] >= 225.0 && @ploc['yaw'] <= 315.0){
        return("east")
    }else if((@ploc['yaw'] >= 315.0 && @ploc['yaw'] <= 360.0) || 
    (@ploc['yaw'] >= 0.0 && @ploc['yaw'] <= 45.0)){
        return("south")
    }else{
        return("west")
    }
)
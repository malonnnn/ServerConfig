proc(_getFullSkullNumber, @machineNumber, 

    array @skull1 = associative_array()
    array @skull2 = associative_array()
    array @skull3 = associative_array()
    @world = 'greenfield'

    
    # Machine 0 is fast travel
    if(@machineNumber == '0'){
        assign(@skull1, array('x': -1747, 'y': 72, 'z': 198, 'world': @world))
        assign(@skull2, array('x': -1746, 'y': 72, 'z': 198, 'world': @world))
        assign(@skull3, array('x': -1745, 'y': 72, 'z': 198, 'world': @world))
    }else if(@machineNumber == '1'){
        assign(@skull1, array('x': -1746, 'y': 72, 'z': 228, 'world': @world))
        assign(@skull2, array('x': -1746, 'y': 72, 'z': 227, 'world': @world))
        assign(@skull3, array('x': -1746, 'y': 72, 'z': 226, 'world': @world))
    }else if(@machineNumber == '2'){
        assign(@skull1, array('x': -1746, 'y': 72, 'z': 222, 'world': @world))
        assign(@skull2, array('x': -1746, 'y': 72, 'z': 221, 'world': @world))
        assign(@skull3, array('x': -1746, 'y': 72, 'z': 220, 'world': @world))
    } else if(@machineNumber == '3'){
        assign(@skull1, array('x': -1746, 'y': 72, 'z': 216, 'world': @world))
        assign(@skull2, array('x': -1746, 'y': 72, 'z': 215, 'world': @world))
        assign(@skull3, array('x': -1746, 'y': 72, 'z': 214, 'world': @world))
    } else if(@machineNumber == '4'){
        assign(@skull1, array('x': -1746, 'y': 72, 'z': 210, 'world': @world))
        assign(@skull2, array('x': -1746, 'y': 72, 'z': 209, 'world': @world))
        assign(@skull3, array('x': -1746, 'y': 72, 'z': 208, 'world': @world))
    }
    
    @block1 = get_metadata(@skull1,"skullNum")
    if(array_index_exists(@block1,'CommandHelper')){
        @num1 = @block1['CommandHelper']
    }else{
        @num1 = 0
    }
    
    @block2 = get_metadata(@skull2,"skullNum")
    if(array_index_exists(@block1,'CommandHelper')){
        @num2 = @block2['CommandHelper']
    }else{
        @num2 = 0
    }
    
    @block3 = get_metadata(@skull3,"skullNum")
    if(array_index_exists(@block1,'CommandHelper')){
        @num3 = @block3['CommandHelper']
    }else{
        @num3 = 0
    }

    return(@num1.@num2.@num3)

)

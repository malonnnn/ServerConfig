proc(_updateHologram, @hologramID, @class, @isOp,
    
    @x = 0
    @y = 0
    @z = 0
    
    if(@hologramID == '1'){
        runas(~console,"/npc select 380")
        @x = -1746.5
        @y = 69
        @z = 226.5
    }else if(@hologramID == '2'){
        runas(~console,"/npc select 381")
        @x = -1746.5
        @y = 69
        @z = 220.5
    }
    else if(@hologramID == '3'){
        runas(~console,"/npc select 382")
        @x = -1746.5
        @y = 69
        @z = 214.5
    }
    else if(@hologramID == '4'){
        runas(~console,"/npc select 383")
        @x = -1746.5
        @y = 69
        @z = 208.5
    }
    
    runas(~console,"/npc spawn")
    if(@class != "remove"){
        runas(~console,"/template apply @class")
#        runas(~console,"/npc despawn")
#        runas(~console,"/npc spawn")
        runas(~console,"/npc moveto --x @x --y @y --z @z")
        if(@isOp == 'true'){
            set_block_at(@x,@y - 1,@z,'35:14','greenfield')
        }else{
            set_block_at(@x,@y - 1,@z,'35:5','greenfield')
        }
    }else{
        runas(~console,"/npc despawn")
        set_block_at(@x,@y - 1,@z,'35:5','greenfield')
    }
    
)

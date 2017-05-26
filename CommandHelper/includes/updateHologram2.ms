proc(_updateHologram2, @class, @isOp, @npcID, @holoLoc,
    
    @x = @holoLoc[0]
    @y = @holoLoc[1]
    @z = @holoLoc[2]
    @world = @holoLoc[3]

    runas(~console,'/npc select '.@npcID)
    console('/npc select '.@npcID)
    if(@class != "remove"){
        #runas(~console,"/npc spawn")
        runas(~console,"/npc despawn @npcID")
        runas(~console,"/template apply @class")
        runas(~console,"/npc moveto --x @x --y @y --z @z")
        if(@isOp == 'true'){
            set_block_at(@x,@y - 1,@z,'35:14',@world)
        }else{
            set_block_at(@x,@y - 1,@z,'35:5',@world)
        }
        
    }else{
        runas(~console,"/template apply remove")
        runas(~console,"/npc moveto --x @x --y @y --z @z")
        set_block_at(@x,@y - 1,@z,'35:5',@world)
    }
    
)

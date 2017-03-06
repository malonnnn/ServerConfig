bind(vehicle_leave,null,associative_array('vehicletype':'MINECART'),@event){
    
    if(@event['player'] == null){
        die()
    }
    @player = @event['player']
    if(pworld(@player) == 'rollercoaster'){
        @minecartID = @event['vehicle']

        set_timeout(500,closure(
            entity_remove(@minecartID)
        ))
    }
}

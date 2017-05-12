bind(vehicle_leave,null,associative_array('vehicletype':'BOAT'),@event){
    
    if(@event['player'] == null){
        die()
    }
    @player = @event['player']
    if(pworld(@player) == 'formuladrift'){
        @minecartID = @event['vehicle']

        set_timeout(500,closure(
            entity_remove(@minecartID)
        ))
    }
}

bind(vehicle_leave,null,associative_array('vehicletype':'BOAT'),@event){
    
    if(@event['player'] == null){
        die()
    }
    @player = @event['player']
    @pworld = pworld(@player)
    if(@pworld == 'formuladrift' || @pworld == 'boatrace'){
        @minecartID = @event['vehicle']

        set_timeout(500,closure(
            entity_remove(@minecartID)
        ))
    }
}

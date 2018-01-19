register_command(push, 
    array(
        description: 'Power',
        permission: 'ch.alias.push',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 3) {
                return(FALSE) 
            }

            @player = player()

            @vic = @args[0]
            @ploc = ploc(@player)
            @vicLoc = ploc(@vic)

            include('/home/minecraft/server/plugins/CommandHelper/includes/distanceBetween.ms')
            @final = _distanceBetween(@ploc,@vicLoc)
            
            @maxDist = @args[1]
            @multiplier = @args[2]
            @magnitude = (1 - @final / @maxDist) * @multiplier

            @yaw = @ploc['yaw'] + 90;
            @pitch = neg(@ploc['pitch']);
            @vector = associative_array();
            @vector['x'] = @magnitude * (cos(to_radians(@yaw)) * cos(to_radians(@pitch)));
            @vector['y'] = @magnitude * sin(to_radians(@pitch));
            @vector['z'] = @magnitude * (sin(to_radians(@yaw)) * cos(to_radians(@pitch)));
            set_pvelocity(@vic,@vector) 
        }
    )
)

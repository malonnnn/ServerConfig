# Set Warp Hook
proc(_setwarp, @playerName, @command,

    @args = parse_args(@command); # Parse the arguements

    if (array_size(@args) <= 2) {	
        
        return(false); # Tell the original function to go ahead (Player didn't supply a third arguement)
        
    }
    
    if(@args[2] == 'locked') {
    
        @player = player(@playerName); # If player is a string, convert it to a player object
        @playersWorld = pworld(@player); # Store the world name of the player	
                
        try {
        
            @database = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/essentials_plus_plus.sqlite'); # Database connection
            @sql = query(@database, 'INSERT OR IGNORE INTO `protected_warps` (warp, world) VALUES(?, ?);',@args[1], @playersWorld); # Add if not exists
            @sql = query(@database, 'UPDATE `protected_warps` SET world = ? WHERE warp=?;',@playersWorld, @args[1]); # Update record if exists
            
        
        } catch (SQLException @ErrorInfo) {
        
            msg(@player, 'SQL Error Occurred. Unable to create protected warp. See console for details');
            console('Essentials Plus Plus SQL Error: '.@ErrorInfo);
            return(true); # Cancel the original function
        
        }
        
        runas(@player, '/setwarp '.@args[1]); # Re-run the command without the unlock arguement since we already have the warp saved
        
        return(true); # Tell the original function to cancel, we'll take it from here (it's being re-run anyways)
        
    } else {
    
        # Delete protected warp because player excecuted /setwarp without the locked flag so if it exists as a locked warp, unlock it
        try {
        
            @database = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/essentials_plus_plus.sqlite'); # Database connection
            @sql = query(@database, 'DELETE FROM `protected_warps` WHERE `warp` = ?;',@args[1]); # Delete the protected warp			
        
        } catch (SQLException @ErrorInfo) {			
                
                console('Essentials Plus Plus SQL Error: '.@ErrorInfo);
                return(true); # Cancel the original function
            
        }
    
        return(false); # Tell the original function to go ahead
    
    }
    
)

# Del Warp Hook
proc(_delwarp, @playerName, @command,

    @args = parse_args(@command); # Parse the arguements

    if (array_size(@args) < 2) {	
        
        return(false); # Tell the original function to go ahead	
        
    }
    
    @player = player(@playerName); # If player is a string, convert it to a player object
    
    try {
        
            @database = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/essentials_plus_plus.sqlite'); # Database connection
            @sql = query(@database, 'DELETE FROM `protected_warps` WHERE `warp` = ?;',@args[1]); # Delete the protected warp			
        
    } catch (SQLException @ErrorInfo) {
        
            msg(@player, 'SQL Error Occurred. Unable to delete protected warp. See console for details');
            console('Essentials Plus Plus SQL Error: '.@ErrorInfo);
            return(true); # Cancel the original function
        
    }	
    
    return(false);
    
)

# Warp Hook
proc(_warp, @playerName, @command,

    @args = parse_args(@command); # Parse the arguements
    if (array_size(@args) < 2) {	
        
        return(false); # Tell the original function to go ahead	
        
    }	
    
    @player = player(@playerName); # Store the name of the player that ran the command
    
    if(!has_permission('essentials.warps.*') || !has_permission('essentials.warps.'@args[1])) {
    
        return(false); # Let the essentials function handle it. This player doesnt have permission to use this warp
    
    }
    

    try {
        
            @database = array(type: 'sqlite', file: '/home/minecraft/server/plugins/CommandHelper/essentials_plus_plus.sqlite'); # Database connection
            @sql = query(@database, 'SELECT * FROM `protected_warps` WHERE `warp`=?;',@args[1]); # Check for the protected warp

            foreach(@result in @sql){
            
                if(@args[1] == @result[warp]){
                
                    @permission = 'multiverse.access.'.@result[world]; # Permission required to access protected warp
                    sudo('/pex user '.@player.' add '.@permission); # Give access to the world
                    set_timeout(1500, closure(sudo('/pex user '.@player.' remove '.@permission))) # Remove access 1.5 seconds later
                    
                    return(false); # Tell the function to go ahead
                
                }
            
            }
        
    } catch (SQLException @ErrorInfo) {
        
            msg(@player, 'SQL Error Occurred. Unable to delete protected warp. See console for details');
            console('Essentials Plus Plus SQL Error: '.@ErrorInfo);
            return(true); # Cancel the original function
        
    }
    
    return(false); # Tell the function to go ahead
)

bind(player_command, null, array(array(prefix: '/warp', prefix: '/setwarp', prefix: '/delwarp')), @Event,
    
    if (@Event[prefix] == "/setwarp") {
    
        if (has_permission(@Event[player], 'essentials.setwarp')) {
        
            if (_setwarp(@Event[player], @Event[command]) == true) {
            
                cancel() # Over-ride the pre-existing warp code (eesentials) only if told to do so
            
            }
            
        }
        
    }
    
    if (@Event[prefix] == "/delwarp") {	
        
    
        if (has_permission(@Event[player], 'essentials.delwarp')) {
        
            if (_delwarp(@Event[player], @Event[command]) == true) {
            
                cancel() # Over-ride the pre-existing warp code (eesentials) only if told to do so
            
            }
            
        }
        
    }
    
    if (@Event[prefix] == "/warp") {
    
        if (has_permission(@Event[player], 'essentials.warp')) {
        
            if (_warp(@Event[player], @Event[command]) == true) {
            
                cancel() # Over-ride the pre-existing warp code (eesentials) only if told to do so
            
            }
        
        }
        
    }	
    
)
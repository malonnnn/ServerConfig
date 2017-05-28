register_command(user_worldperm_add, 

    array(
    
        description: 'Adds a permission to a player for the current world',
        
        permission: 'ch.pex_plus_plus',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {		
        
                if (array_size(@args) != 2) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /user_worldperm_add <player> <permission>');
                    die(); # No need to go further						
                
                }
                
                @playerThatRanCmd = player(); # Store the name of the player that ran the command
                @playerWorld = pworld(@playerThatRanCmd); # Store the name of the world the player is currently in

                sudo('/pex user '.@args[0].' add '.@args[1].' '.@playerWorld); # Add the permission to the current world
        }
    )
)

register_command(user_worldperm_remove, 

    array(
    
        description: 'Removes a permission from a player for the current world',
        
        permission: 'ch.pex_plus_plus',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {		
        
                if (array_size(@args) != 2) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /user_worldperm_remove <player> <permission>');
                    die(); # No need to go further						
                
                }
                
                @playerThatRanCmd = player(); # Store the name of the player that ran the command
                @playerWorld = pworld(@playerThatRanCmd); # Store the name of the world the player is currently in

                sudo('/pex user '.@args[0].' remove '.@args[1].' '.@playerWorld); # Add the permission to the current world
        }
    )
)

register_command(user_globalperm_add, 

    array(
    
        description: 'Adds a permission to a player globally',
        
        permission: 'ch.pex_plus_plus',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {		
        
                if (array_size(@args) != 2) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /user_globalperm_add <player> <permission>');
                    die(); # No need to go further						
                
                }
                
                @playerThatRanCmd = player(); # Store the name of the player that ran the command
                @playerWorld = pworld(@playerThatRanCmd); # Store the name of the world the player is currently in

                sudo('/pex user '.@args[0].' add '.@args[1]); # Add the permission
        }
    )
)

register_command(user_globalperm_remove, 

    array(
    
        description: 'Removes a permission from a player globally',
        
        permission: 'ch.pex_plus_plus',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {		
        
                if (array_size(@args) != 2) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /user_globalperm_remove <player> <permission>');
                    die(); # No need to go further						
                
                }
                
                @playerThatRanCmd = player(); # Store the name of the player that ran the command
                sudo('/pex user '.@args[0].' remove '.@args[1]); # Add the permission
        }
    )
)

register_command(group_worldperm_add, 

    array(
    
        description: 'Adds a permission to a group for the current world',
        
        permission: 'ch.pex_plus_plus',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {		
        
                if (array_size(@args) != 2) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /group_worldperm_add <group> <permission>');
                    die(); # No need to go further						
                
                }
                
                @playerThatRanCmd = player(); # Store the name of the player that ran the command
                @playerWorld = pworld(@playerThatRanCmd); # Store the name of the world the player is currently in

                sudo('/pex group '.@args[0].' add '.@args[1].' '.@playerWorld); # Add the permission to the current world
        }
    )
)

register_command(group_worldperm_remove, 

    array(
    
        description: 'Removes a permission from a group for the current world',
        
        permission: 'ch.pex_plus_plus',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {		
        
                if (array_size(@args) != 2) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /group_worldperm_remove <group> <permission>');
                    die(); # No need to go further						
                
                }
                
                @playerThatRanCmd = player(); # Store the name of the player that ran the command
                @playerWorld = pworld(@playerThatRanCmd); # Store the name of the world the player is currently in

                sudo('/pex group '.@args[0].' remove '.@args[1].' '.@playerWorld); # Add the permission to the current world
        }
    )
)

register_command(group_globalperm_add, 

    array(
    
        description: 'Adds a permission to a group globally',
        
        permission: 'ch.pex_plus_plus',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {		
        
                if (array_size(@args) != 2) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /group_globalperm_add <group> <permission>');
                    die(); # No need to go further						
                
                }
                
                @playerThatRanCmd = player(); # Store the name of the player that ran the command
                sudo('/pex group '.@args[0].' add '.@args[1]); # Add the permission
        }
    )
)

register_command(group_globalperm_remove, 

    array(
    
        description: 'Removes a permission from a group globally',
        
        permission: 'ch.pex_plus_plus',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {		
        
                if (array_size(@args) != 2) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /group_globalperm_remove <group> <permission>');
                    die(); # No need to go further						
                
                }
                
                @playerThatRanCmd = player(); # Store the name of the player that ran the command
                sudo('/pex group '.@args[0].' remove '.@args[1]); # Add the permission
        }
    )
)
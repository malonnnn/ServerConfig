register_command(hiresecretary, 

    array(
    
        description: 'Hire\'s a Player as a Secretary',
        
        usage: '/hiresecretary <player>',
        
        permission: 'ch.alias.hiresecretary',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        tabcompleter: closure(@alias, @sender, @args) {
            try{
                if(array_size(@args) == 0) {
                    return(all_players());
                }
                @search = @args[array_size(@args) - 1];
                    return(array_filter(all_players(), closure(@index, @player) {
                    return(equals_ic(@search, substr(@player, 0, length(@search))));
                }));
            } catch (RangeException @ErrorInfo) {
                # Ignore
            }
        },
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /hiresecretary <player>');
                    die(); # No need to go further					
                
                }
                
                try {
                
                    @player = player(@args[0])
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }		
                
                runas(~console,"/pex user ".@player." add is.secretary")
                runas(~console,"/pex user ".@player." add multiverse.access.office")
                runas(~console,"/pex user ".@player." add essentials.warps.officeadmin")
                runas(~console,"/pex user ".@player." add essentials.warps.office")
                runas(~console,"/pex user ".@player." add is.secretary")
                runas(~console,"/pex user ".@player." add ch.alias.officekill office")
                tmsg(player(),color(red)."You have hired ".@player. " as secretary")
                tmsg(@player,color(red)."You have been hired as secretary")
        
        }
    )
)

register_command(firesecretary, 

    array(
    
        description: 'Fire\'s a Player as a Secretary',
        
        usage: '/firesecretary <player>',
        
        permission: 'ch.alias.firesecretary',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        tabcompleter: closure(@alias, @sender, @args) {
            try{
                if(array_size(@args) == 0) {
                    return(all_players());
                }
                @search = @args[array_size(@args) - 1];
                    return(array_filter(all_players(), closure(@index, @player) {
                    return(equals_ic(@search, substr(@player, 0, length(@search))));
                }));
            } catch (RangeException @ErrorInfo) {
                # Ignore
            }
        },
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /firesecretary <player>');
                    die(); # No need to go further					
                
                }
                
                try {
                
                    @player = player(@args[0])
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }				
                
                if(has_permission(@player,"is.secretary")){
                    runas(~console,"/pex user ".@player." remove is.secretary")
                    runas(~console,"/pex user ".@player." remove multiverse.access.office")
                    runas(~console,"/pex user ".@player." remove essentials.warps.officeadmin")
                    runas(~console,"/pex user ".@player." remove essentials.warps.office")
                    runas(~console,"/pex user ".@player." remove ch.alias.officekill office")
                    tmsg(player(),color(red)."You have fired ". @player ." from secretary!")
                    tmsg(@player,color(red)."You have been fired from secretary!")
                }
        
        }
    )
)

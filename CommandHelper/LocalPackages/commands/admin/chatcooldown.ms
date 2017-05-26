register_command(addchatcooldown, 

    array(
    
        description: 'Adds a cooldown timer to a players chat. Helps with spammers',
        
        usage: '/addchatcooldown <player>',
        
        permission: 'ch.alias.addchatcooldown',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        aliases: 'addchattimer',
        
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
                    msg(''.color(RED).'Usage: /addchatcooldown <player>');
                    die(); # No need to go further					
                
                }
                
                try {
                    @plr = player(@args[0])
                    @player = player()
                    
                    sudo("/pex user ".@plr." add chat.cooldown")
                    tmsg(@plr,color(red).'You have been given a chat cooldown by '.@player.' for spamming!')
                    tmsg(@player,color(red).'You have given '.@plr.' a chat cooldown!')	
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }				
                
                            
        
        }
    )
)

register_command(remchatcooldown, 

    array(
    
        description: 'Removes a cooldown timer from a player',
        
        usage: '/remchatcooldown <player>',
        
        permission: 'ch.alias.remchatcooldown',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        aliases: 'remchattimer',
        
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
                    msg(''.color(RED).'Usage: /addchatcooldown <player>');
                    die(); # No need to go further					
                
                }				
                
                try {
                    @plr = player(@args[0])
                    @player = player()
                    
                    sudo("/pex user ".@plr." remove chat.cooldown")
                    tmsg(@plr,color(red).'Your chat cooldown has been removed by '.@player.'!')
                    tmsg(@player,color(red).'You have remove the chat cooldown for '.@plr.'!')
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }
                
        
        }
    )
)

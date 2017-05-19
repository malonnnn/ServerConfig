register_command(coinflip, 

    array(
    
        description: 'Flips a Coin',
        
        usage: '/coinflip',
        
        permission: 'ch.alias.coinflip',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command. It\'s a shame..',
    
        executor: closure() {
        
                try {
                
                    @plr = player(); # Store player that ran command
                    @num = rand(1,3)
                    broadcast("@plr has flipped a coin! The result is...")
                    
                    set_timeout(2000,closure(
                        if(@num == 1)
                        {
                            broadcast("HEADS!")
                        }else
                        {
                            broadcast("TAILS!")
                        }
                    ))
                    
                } catch (PlayerOfflineException @ErrorInfo) {
                
                    msg('Error Running Command: Player Offline Exception Raised'); # Just in case the command is run from the console
                    die(); # Stop the command
                
                } catch (NotFoundException @ErrorInfo) {
                
                    msg('Error Running Command: Player Not Found'); # Just to be safe
                    die(); # Stop the command					
                
                }				
        
        }
    )
)

register_command(deathroll, 
    array(
        description: '',
        usage: '/deathroll <player>',
        permission: 'ch.alias.deathroll',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /deathroll <player>');
                    die(); # No need to go further					
                
                }
                
                try {
                    @player = player(@args[0])
                    
                    if(acc_balance(@player) >= 300){
                    acc_subtract(@player,300)
                    }else{
                        tmsg(@player, "You need $1000 to use this machine!")
                        die()
                    }
                    
                    #@player = player()
                    assign(@plrs, all_players())
                    assign(@plr, array_rand(@plrs))
                    broadcast(color(DARK_RED).color(RANDOM)."k".color(BLUE).@player.color(GRAY)." used ".color(RED)."DeathRoll".color(GRAY)."! Who will ".color(DARK_RED).color(BOLD)."DIE".color(GRAY)."? Will it be ".color(WHITE).@plrs[@plr[0]].color(GRAY)."?")
                    
                    set_timeout(2000, closure(
                    assign(@plr, array_rand(@plrs))
                        broadcast(color(DARK_RED).color(RANDOM)."k".color(GRAY)." or ".color(WHITE).@plrs[@plr[0]].color(GRAY)."?")
                    ))
                    
                    set_timeout(4000, closure(
                        broadcast(color(DARK_RED).color(RANDOM)."k".color(GRAY)." No! It")
                    ))
                    
                    set_timeout(5000, closure(
                        broadcast(color(DARK_RED).color(RANDOM)."k".color(GRAY)." Will")
                    ))
                    
                    set_timeout(6000, closure(
                        broadcast(color(DARK_RED).color(RANDOM)."k".color(GRAY)." Be")
                    ))
                    
                    set_timeout(7000, closure(
                        broadcast(color(DARK_RED).color(RANDOM)."k".color(GRAY)." ...")
                    ))
                    
                    set_timeout(10000, closure(
                    assign(@plr, array_rand(@plrs))
                    @name = @plrs[@plr[0]]
                    if(rand(1,3) == 1){
                        broadcast(color(DARK_GREEN).color(RANDOM)."k".color(GRAY)."JK! ".color(WHITE).@name.color(GRAY)." wins ".color(GREEN)."$300")
                        runas(~console,'/eco give '.@name.' 300')
                        die()
                    }
                    @mode = pmode(@name)
                    broadcast(color(DARK_RED).color(RANDOM)."k".color(DARK_RED)." ".@name)
                        set_timeout(500, closure(
                            pkill(@name)
                        ))
                    ))	
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }				
                
                    
        
        }
    )
)
register_command(slaproll, 
    array(
        description: '',
        usage: '/slaproll',
        permission: 'command.uberslaproll',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
    
            if (array_size(@args) != 0) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /slaproll');
                die(); # No need to go further					
            
            }
            
            assign(@plrs, all_players())
            assign(@plr, array_rand(@plrs))
            broadcast(
                color(DARK_RED).color(BOLD).color(RANDOM)."k".
                color(GREEN).color(BOLD)." RANDOM UBERSLAP COMING IN 3..."

            )
            
            set_timeout(1000, closure(
                broadcast(
                    color(DARK_RED).color(BOLD).color(RANDOM)."k".
                    color(GREEN).color(BOLD)." 2..."

                )
            ))
            
            set_timeout(2000, closure(
                broadcast(
                    color(DARK_RED).color(BOLD).color(RANDOM)."k".
                    color(GREEN).color(BOLD)." 1..."

                )
            ))
            
            
            set_timeout(3000, closure(
            assign(@plr, array_rand(@plrs))
            @name = @plrs[@plr[0]]
            sudo("/uberslap ".@name)
            ))
        
        }
    )
)

register_command(annoy, 

    array(
    
        description: 'Annoy\'s a player',
        
        usage: '/annoy <player> <loop delay in milleseconds>',
        
        permission: 'ch.alias.annoy',
        
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
        
                if (array_size(@args) != 2) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /annoy <player> <loop delay in milleseconds>');
                    die(); # No need to go further					
                
                }
                
                try {
                    @them = player(@args[0])
                    @me = player()
                    @vicUUID = puuid(@plr)
                    @ip = pinfo(@plr)[3]
                    
                    @delay = @args[1]
                

                    # if we are already annoying someone, cancel their loop
                    @id = import('annoying')
                    try(
                        clear_task(@id)
                    ,
                        continue()
                    )
                    # Teleport me to them immediately
                    @ploc = ploc(@them)
                    set_ploc(@me,@ploc)

                    # 1 tick later, set me to flying and creative so they dont kill me
                    set_timeout(50,closure(
                        set_pmode(@me,'CREATIVE')
                        set_pflight(@me, true)
                        set_pflying(@me, true)
                    ))

                    # begin main loop
                    @id = set_interval(@delay,closure(
                        
                        # Teleport me to them
                        # ploc() returns xyz and pitch/yaw values
                        @ploc = ploc(@them)
                        set_ploc(@me,@ploc)
                        
                        # 1 tick later, set me to flying and creative so they dont kill me
                        set_timeout(50,closure(
                            set_pmode(@me,'CREATIVE')
                            set_pflight(@me, true)
                            set_pflying(@me, true)
                        ))
                    ))
                    # save the loops unique ID to a global register so we can cancel it at any arbitrary time
                    export('annoying',@id)	
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }
                
                    
        
        }
    )
)

register_command(stopannoy, 

    array(
    
        description: 'Stop\'s annoying a player',
        
        usage: '/stopannoy',
        
        permission: 'ch.alias.annoy',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',		
    
        executor: closure() {				
                
                # import annoying unique ID task from global register
                # null if it's unset
                # if cancel_task() fails
                # then continue script as if nothing happened
                @id = import('annoying')

                # try to cancel the annoyance task
                try(
                    clear_task(@id)
                ,
                    continue()
                )	
        
        }
    )
)

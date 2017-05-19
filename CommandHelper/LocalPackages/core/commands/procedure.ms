register_command(procedure, 

    array(
    
        description: 'Displays procedure information for server staff',
        
        usage: '/procedure <hero/feature/bugs>',
        
        permission: 'ch.alias.proc',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        tabcompleter: closure(@alias, @sender, @args) {
            try{
                if(array_size(@args) == 0) {
                    return(array('hero', 'feature', 'bugs'));
                }
                @search = @args[array_size(@args) - 1];
                    return(array_filter(array('hero', 'feature', 'bugs'), closure(@index, @player) {
                    return(equals_ic(@search, substr(@player, 0, length(@search))));
                }));
            } catch (RangeException @ErrorInfo) {
                # Ignore
            }
        },
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /proc <procedure>');
                    die(); # No need to go further					
                
                }	
                
                @type = @args[0]
                @plr = player()
                if(@type == 'hero'){
                    tmsg(@plr,color(red).'https://docs.google.com/drawings/d/1e17T57bpLOozgQ1u46JnBqqtDg3Hz1i_jlDDMk9K5S8/edit')
                }else if(@type == 'feature'){
                    tmsg(@plr,color(red).'https://docs.google.com/drawings/d/1e17T57bpLOozgQ1u46JnBqqtDg3Hz1i_jlDDMk9K5S8/edit')
                }else if(@type == 'bugs'){
                    tmsg(@plr,color(red).'https://docs.google.com/drawings/d/1472fzcqPPMypP9LIs2jeXnkBq4N_WcCTVSymNaEzGZQ/edit')
                }else{
                    tmsg(@plr,color(red).'Sorry, that\'s not a recognized type')
                }	
        
        }
    )
)

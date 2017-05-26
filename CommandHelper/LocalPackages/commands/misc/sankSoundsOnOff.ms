register_command(chatsounds, 

    array(
    
        description: 'Turn the Server Chat Sounds on or Off',
        
        usage: '/chatsounds <on/off>',
        
        permission: 'ch.alias.chatsounds',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        tabcompleter: closure(@alias, @sender, @args) {
            try{
                if(array_size(@args) == 0) {
                    return(array('on', 'off'));
                }
                @search = @args[array_size(@args) - 1];
                    return(array_filter(array('on', 'off'), closure(@index, @player) {
                    return(equals_ic(@search, substr(@player, 0, length(@search))));
                }));
            } catch (RangeException @ErrorInfo) {
                # Ignore
            }
        },
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /chatsounds <on/off>');
                    die(); # No need to go further					
                
                }				
                    
                @plr = player()
                assign(@coolDown, 60)
                assign(@lastChatSounds, import(@plr.'lastchatsounds'))
                if(@lastChatSounds + @coolDown > time() / 1000)
                {
                    assign(@timeleft, subtract(add(@lastChatSounds, @coolDown), divide(time(),1000)))
                    tmsg(@plr, color(red) . "[ " . color(dark_red) . "Error" . color(red) . " ] " . color(gray) . "You must wait another " . color(dark_red) . round(@timeleft) . color(gray) . " seconds before you can use /chatsounds again!")
                    die()
                }
                export(@plr.'lastchatsounds', time() / 1000)
                
                @onoff = @args[0]
                export(@plr.'chatsounds',@onoff)

                if(@onoff == 'off'){
                    tmsg(@plr,color(red).'You have '.color(dark_red).'disabled '.color(red).'chat sounds!')
                    broadcast(@plr.color(red).' has '.color(dark_red).'disabled '.color(red).'chat sounds! '.color(gold).'/chatsounds off')
                }else{
                    tmsg(@plr,color(red).'You have '.color(green).'enabled '.color(red).'chat sounds!')
                    broadcast(@plr.color(red).' has '.color(green).'enabled '.color(red).'chat sounds! '.color(gold).'/chatsounds on')
                }
        
        }
    )
)

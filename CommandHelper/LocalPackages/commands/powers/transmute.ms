register_command(transmute, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.transmute',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /transmute <block>');
                die(); # No need to go further					
            
            }
            
            @block = @args[0]
            @player = player()
            @items = pinv(@player,null)
            try(
                set_pinv(array(null: array(type: 0)))
                runas(~console,"/give ".@player." ".@block." ".@items['qty'])
            ,
                tmsg(@player,color(red)."Make sure to hold the item that you want to transmute")
            )
            
        }
    )
)
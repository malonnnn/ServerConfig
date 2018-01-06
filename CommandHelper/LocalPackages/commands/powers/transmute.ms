register_command(transmute, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.transmute',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
            @numArgs = array_size(@args)
            if (@numArgs < 1 || @numArgs > 2) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /transmute <block>');
                die(); # No need to go further					
            
            }
            if(@numArgs == 1){
                @color = ""
            }else{
                @color = @args[1]
            }
            @block = @args[0]
            @player = player()
            @items = pinv(@player,null)
            try(
                set_pinv(array(null: array(type: 0)))
                runas(~console,"/minecraft:give ".@player." ".@block." ".@items['qty']." ".@color)
            ,
                tmsg(@player,color(red)."Make sure to hold the item that you want to transmute")
            )
            
        }
    )
)

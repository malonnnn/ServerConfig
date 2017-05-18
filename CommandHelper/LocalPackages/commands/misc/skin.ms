register_command(skin, 

    array(
    
        description: 'Change your Hero Skin to an Alternate Skin',
        
        usage: '/skin <number>',
        
        permission: 'ch.alias.skin',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        tabcompleter: closure(@alias, @sender, @args) {
            try{
                if(array_size(@args) == 0) {
                    return(array('1', '2'));
                }
                @search = @args[array_size(@args) - 1];
                    return(array_filter(array('1', '2'), closure(@index, @player) {
                    return(equals_ic(@search, substr(@player, 0, length(@search))));
                }));

            } catch (RangeException @ErrorInfo) {

                # Ignore

            }
        },
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) != 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /skin <number>');
                    die(); # No need to go further					
                
                }
                
                try {
                
                    @player = player()
                    @class = pgroup()[0]
                    
                } catch (PlayerOfflineException @ErrorInfo) {				
                    msg(@player,'Player: '.@plr.' is Offline')
                    die()
                }				
                
                include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')    
                
                @skinNum = @args[0]

                if(@skinNum <= 0){
                    tmsg(@player,"Skin number has to be at least 1")
                    die()
                }
                
                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms')
                
                if(@skinNum == "1"){
                    @sig = @hero['sig']
                    @val = @hero['val']
                    _changeSkin(@player,@sig,@val)
                    die()
                }
                @skinNum = @skinNum - 2
                try(
                    @altSig = @hero['altskins'][@skinNum]['sig']
                    @altVal = @hero['altskins'][@skinNum]['val']
                ,
                    @skinNum = @skinNum + 2
                    tmsg(@player,"Sorry, this hero doesn't have a skin number ". @skinNum)
                    die()
                )
                _changeSkin(@player,@altSig,@altVal)
        
        }
    )
)

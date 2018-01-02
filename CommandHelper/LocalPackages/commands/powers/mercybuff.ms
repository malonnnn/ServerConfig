register_command(mercybuff, 

    array(
    
        description: 'Power',
        permission: 'ch.alias.mercybuff',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) == 0) {
            
                @player = player()
                assign(@cooldown, 60)
                
                assign(@lastUsedMercyBuff, import(@player."lastUsedMercyBuff"))
                if(@lastUsedMercyBuff + @cooldown > time() / 1000,
                    assign(@timeleft, subtract(add(@lastUsedMercyBuff, @cooldown), divide(time(),1000)))
                    tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use healing again!'))
                    die()
                )
                export(@player."lastUsedMercyBuff", time() / 1000)
                runas(~console,'/effect '.@player.' regeneration 20 2 true')
                tmsg(@player,color(red).'You have buffed!')
                die()				
            
            } else if (array_size(@args) == 1) {
            
                @player = player()
                @plr = @args[0]
                @plr = player(@plr)

                if(has_permission(@plr,'is.criminal')){
                    msg(color(RED).'Sorry, that player is a criminal, you can\'t do that right now.')
                    die()
                }

                assign(@cooldown, 60)
                assign(@lastUsedMercyBuff, import(@player."lastUsedMercyBuff"))
                if(@lastUsedMercyBuff + @cooldown > time() / 1000,
                    assign(@timeleft, subtract(add(@lastUsedMercyBuff, @cooldown), divide(time(),1000)))
                    tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use healing again!'))
                    die()
                )
                export(@player."lastUsedMercyBuff", time() / 1000)
                runas(~console,'/effect '.@plr.' regeneration 20 2 true')
                tmsg(@player,color(red).'You have buffed '.@plr.'!')
                tmsg(@plr,color(red).'You were buffed by '.@player.'!')
                die()
            
            } else {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /mercybuff [player]');
                die(); # No need to go further	
            
            }
            
        }
    )
)

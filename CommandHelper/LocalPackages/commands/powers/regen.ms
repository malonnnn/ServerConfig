register_command(regen, 

    array(
    
        description: 'Power',
        permission: 'powers.regen',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) == 0) {
            
                @player = player()
                assign(@cooldown, 60)
                
                assign(@lastUsedRegen, import(@player."lastUsedRegen"))
                if(@lastUsedRegen + @cooldown > time() / 1000,
                    assign(@timeleft, subtract(add(@lastUsedRegen, @cooldown), divide(time(),1000)))
                    tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use regen again!'))
                    die()
                )
                export(@player."lastUsedRegen", time() / 1000)
                runas(~console,'/effect '.@player.' regeneration 20 1 true')
                tmsg(@player,color(red).'You are regenning!')
                die()				
            
            } else if (array_size(@args) == 1) {
            
                @player = player()
                @plr = @args[0]
                @plr = player(@plr)

                if(has_permission(@plr,'is.criminal')){
                    msg(color(RED).'Sorry, that player is a criminal, you can\'t do that right now.')
                    die()
                }

                @plrsRad = players_in_radius(ploc(@player),15)
                @found = false
                foreach(@pllrr in @plrsRad){
                    if(@pllrr == @plr){
                        @found = true
                        break()
                    }
                }
                if(!@found){
                    msg(color(RED).'Sorry, you have to be within 15 blocks of that player to use this')
                    die()
                }

                assign(@cooldown, 60)
                assign(@lastUsedRegen, import(@player."lastUsedRegen"))
                if(@lastUsedRegen + @cooldown > time() / 1000,
                    assign(@timeleft, subtract(add(@lastUsedRegen, @cooldown), divide(time(),1000)))
                    tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use regen again!'))
                    die()
                )
                export(@player."lastUsedRegen", time() / 1000)
                runas(~console,'/effect '.@player.' regeneration 20 1 true')
                tmsg(@player,color(red).'You are regenning '.@plr.'!')
                tmsg(@plr,color(red).'You are regenning by '.@player.'!')
                die()
            
            } else {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /regen [player]');
                die(); # No need to go further	
            
            }
            
        }
    )
)

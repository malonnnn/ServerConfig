register_command(healing, 

    array(
    
        description: 'Power',
        permission: 'ch.alias.healing',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) == 0) {
            
                @player = player()
                assign(@cooldown, 60)
                
                assign(@lastUsedHealing, import(@player."lastUsedHealing"))
                if(@lastUsedHealing + @cooldown > time() / 1000,
                    assign(@timeleft, subtract(add(@lastUsedHealing, @cooldown), divide(time(),1000)))
                    tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use healing again!'))
                    die()
                )
                export(@player."lastUsedHealing", time() / 1000)
                runas(~console,'/effect '.@player.' regeneration 5 10 true')
                tmsg(@player,color(red).'You have healed!')
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
                assign(@lastUsedHealing, import(@player."lastUsedHealing"))
                if(@lastUsedHealing + @cooldown > time() / 1000,
                    assign(@timeleft, subtract(add(@lastUsedHealing, @cooldown), divide(time(),1000)))
                    tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use healing again!'))
                    die()
                )
                export(@player."lastUsedHealing", time() / 1000)
                runas(~console,'/effect '.@plr.' regeneration 5 10 true')
                tmsg(@player,color(red).'You have healed '.@plr.'!')
                tmsg(@plr,color(red).'You were healed by '.@player.'!')
                die()
            
            } else {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /healing [player]');
                die(); # No need to go further	
            
            }
            
        }
    )
)

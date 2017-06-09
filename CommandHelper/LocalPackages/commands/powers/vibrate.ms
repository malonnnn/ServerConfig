register_command(vibrate, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.vibrate',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
            
            @player = player()
            assign(@cooldown, 60)
            
            assign(@lastUsedVibrate, import(@player."lastUsedVibrate"))
            if(@lastUsedVibrate + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedVibrate, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use vibrate again!'))
                die()
            )
            export(@plr."lastUsedVibrate", time() / 1000)

            @player = player()
            runas(~console,"/effect " . @player . " 11 9999 4 true")
            @eventID = set_interval(100,closure(
                @ploc = ploc()
                @ploc['x'] = @ploc['x'] + 0.1
                set_ploc(@ploc)
                set_timeout(50,closure(
                    @ploc['x'] = @ploc['x'] - 0.1
                    set_ploc(@ploc)
                ))
                
            ))
            set_timeout(10000,closure(
                clear_task(@eventID)
                runas(~console,"/effect " . @player . " 11 0")
            ))

            export(@player."isVibrating",@eventID)
                
        }
    )
)

register_command(stopvibrating, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.stopvibrating',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
            
            @player = player()
            runas(~console,"/effect " . @player . " 11 0")
            @eventID = import(@player."isVibrating")
            clear_task(@eventID)
                
        }
    )
)

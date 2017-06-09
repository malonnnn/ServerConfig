register_command(stoptime, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.stoptime',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
            
            @player = player()
            assign(@cooldown, 120)
            
            assign(@lastUsedStopTime, import(@player."lastUsedStopTime"))
            if(@lastUsedStopTime + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedStopTime, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use stoptime again!'))
                die()
            )
            export(@player."lastUsedStopTime", time() / 1000)

            runas(~console,'/effect '.@player.' 1 60 255 true')
                
        }
    )
)

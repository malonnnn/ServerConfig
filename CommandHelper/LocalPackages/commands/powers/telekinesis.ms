register_command(telekineis, 
    array(
        description: 'Power',
        permission: 'ch.alias.telekineis',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                return(false)
            }
            
            @player = player()
            @plr = @args[0]
            assign(@cooldown, 10)
            
            assign(@lastUsedTelekinesis, import(@player."lastUsedTelekinesis"))
            if(@lastUsedTelekinesis + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedTelekinesis, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use force push again!'))
                die()
            )
            export(@player."lastUsedTelekinesis", time() / 1000)
            sudo("/push ".@plr)
            tmsg(@plr,"You have been pushed by ".@player."!")
            tmsg(player(),"You have pushed ".@plr."!")
                
        }
    )
)

register_command(wind, 
    array(
        description: 'Power',
        permission: 'ch.alias.wind',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /wind <player>');
                die(); # No need to go further					
            
            }
            
            @player = player()
            @plr = @args[0]
            assign(@cooldown, 10)
            
            assign(@lastUsedWind, import(@player."lastUsedWind"))
            if(@lastUsedWind + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedWind, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use /wind again!'))
                die()
            )
            export(@player."lastUsedWind", time() / 1000)
            sudo("/push ".@plr)
            tmsg(@plr,"You have been pushed by ".@player."!")
            tmsg(player(),"You have pushed ".@plr."!")
                
        }
    )
)

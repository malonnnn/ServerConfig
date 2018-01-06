register_command(mainmenu, 

    array(
        description: 'Unplugs from The Matrix',
        permission: 'command.mainmenu',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {        
            
            @plr = player()
            assign(@cooldown, 10)
            
            assign(@lastUsedMindLock, import(@plr."lastUsedMainMenu"))
            if(@lastUsedMindLock + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedMindLock, @cooldown), divide(time(),1000)))
                tmsg(@plr,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use this again!'))
                die()
            )

            include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
            _mortal(@plr)
            runas(~console,'/warp mainmenu '.@plr)
            set_timeout(3100,closure(
                set_peffect(@plr,14,1,9999,true, false)
            ))

        }
    )
)

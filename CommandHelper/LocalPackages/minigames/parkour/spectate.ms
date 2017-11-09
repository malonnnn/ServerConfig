register_command(parkourspec, 
    array(
        description: 'Enter Spectator Mode',
        usage: '/spec',
        permission: 'command.spec',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {
                
                @plr = player()
                
                set_pmode(@plr,'SPECTATOR')
                set_pflight(@plr,true) 
                set_pflying(@plr,true) 
        }
    )
)
register_command(parkourunspec,
    array(
        description: 'Leave Spectator Mode',
        usage: '/unspec',
        permission: 'command.unspec',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {
                
                @plr = player()
                
                set_pmode(@plr,'SURVIVAL')
                set_pflight(@plr,false)
                sudo('/mv tp '.pworld(@plr))
        
        }
    )
)

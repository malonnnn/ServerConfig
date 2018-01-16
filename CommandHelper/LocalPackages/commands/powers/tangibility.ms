register_command(intangible, 
    array(
        description: 'Power',
        permission: 'ch.alias.intangible',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {
            @plr = player()
            sudo('/minecraft:clear '.@plr) 
            sudo(/gm 3)
            set_pflight(@plr,true)
            set_pflying(@plr,true)
        }
    )
)

register_command(tangible, 
    array(
        description: 'Power',
        permission: 'ch.alias.tangible',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {        
            @plr = player()
            sudo(/gms)
            if(!has_permission(@plr,'essentials.fly')){
                set_pflight(@plr,false)
            }
            if(has_permission(@plr,'ch.alias.buff')){
                runas(@plr,'/buff')
            }
        }
    )
)

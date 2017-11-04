register_command(eat, 

    array(
        description: 'Eat the world',
        permission: 'power.eat',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {
        
            @plr = player()
            @world = pworld(@plr)
            @plrs = all_players(@world)

            include('/home/minecraft/server/plugins/CommandHelper/includes/livingEntities.ms')
           
            sudo('/minecraft:kill @e['.@types.']') 
            msg('/minecraft:kill @e['.@types.']') 
            
            include('/home/minecraft/server/plugins/CommandHelper/includes/commandCooldown.ms')
            _commandCooldown(@plr,1200,"lastUsedEat")
            
            broadcast(@plr." ate ".@world." and killed everyone within it") 
        }
    )
)

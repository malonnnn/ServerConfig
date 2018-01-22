register_command(cloneself, 
    array(
        description: 'Power',
        permission: 'powers.cloneself',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 0) {
                return(false)
            }
            
            @player = player()

            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @class = _getheroclass(@player)            
            include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@class.'.ms')
            @sig = @hero['sig']
            @val = @hero['val']

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedIllusionPlayer',1,@player)

            @mobUUIDs = spawn_mob('villager',1)
            set_timeout(50,closure(
                runas(~console,"/disguiseplayer ".@mobUUIDs[0].' player '.@player.' setskin {"id":"87fb3c6c5ff64bf6b326992c6137ea12","name":"tektronic","properties":[{"signature":"'.@sig.'","name":"textures","value":"'.@val.'"}]}')
            ))
            
        }
    )
)
register_command(splitself, 
    array(
        description: 'Power',
        permission: 'powers.splitself',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 0) {
                return(false)
            }
            
            @player = player()

            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @class = _getheroclass(@player)            
            include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@class.'.ms')
            @sig = @hero['sig']
            @val = @hero['val']

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedIllusionPlayer',1,@player)

            @mobUUIDs = spawn_mob('wolf:tamed',5)
            set_timeout(50,closure(
                foreach(@uuid in @mobUUIDs){
                    runas(~console,"/disguiseplayer ".@uuid.' player '.@player.' setskin {"id":"87fb3c6c5ff64bf6b326992c6137ea12","name":"tektronic","properties":[{"signature":"'.@sig.'","name":"textures","value":"'.@val.'"}]}')
                    tame_mob(@player,@uuid)
                }
            ))
            
        }
    )
)

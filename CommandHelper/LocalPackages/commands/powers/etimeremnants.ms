register_command(etimeremnants, 
    array(
        description: 'Power',
        permission: 'powers.etimeremnants',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 0) {
                return(false)
            }
            
            @player = player()

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('etimeremnants',10,@player)

            @oldMobs = import(@player.'etimeremnantsClones')
            if(is_array(@oldMobs)){
                foreach(@mob in @oldMobs){
                    try(entity_remove(@mob),continue())
                }
            }

            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @class = _getheroclass(@player)            
            include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@class.'.ms')
            @sig = @hero['sig']
            @val = @hero['val']

            @mobUUIDs = spawn_mob('wolf:tamed',5)
            export(@player.'etimeremnantsClones',@mobUUIDs)
            set_timeout(50,closure(
                foreach(@uuid in @mobUUIDs){
                    runas(~console,"/disguiseplayer ".@uuid.' player '.@player.' setskin {"id":"87fb3c6c5ff64bf6b326992c6137ea12","name":"tektronic","properties":[{"signature":"'.@sig.'","name":"textures","value":"'.@val.'"}]}')
                    tame_mob(@player,@uuid)
                    set_mob_effect(@uuid, 5, 10, 9999, true, false)
                    set_mob_effect(@uuid, 10, 3, 9999, true, false)
                    set_mob_effect(@uuid, 21, 4, 9999, true, false)
                    set_mob_effect(@uuid, 1, 4, 9999, true, false)
                }
            ))
        }
    )
)

register_command(illusionplayer, 
    array(
        description: 'Power',
        permission: 'ch.alias.illusion',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
            @numArgs = array_size(@args)
            if (@numArgs < 3 || @numArgs > 4) {
                return(false)
            }
            
            @player = @sender
            @num = @args[0]
            @mobType = @args[1]
            @playerName = @args[2]
            @tame = ''
            if(array_index_exists(@args,3) && @args[3] == true){
                @tame = true
            }

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedIllusionPlayer',1,@player)

            if(!is_null(import(@player."illusion"))){
                @oldMobs = import(@player."illusion")
                foreach(@uuid in @oldMobs){
                    try(entity_remove(@uuid),
                    continue())
                }
            }
            
            @mobUUIDs = spawn_mob(@mobType,@num)
            export(@player."illusion",@mobUUIDs)
            set_timeout(50,closure(
                foreach(@uuid in @mobUUIDs){
                    runas(~console,'/disguiseplayer '.@uuid.' player '.@playerName)
                    if(@tame){
                        tame_mob(@player,@uuid) 
                    }
                } 
            ))
            
        }
    )
)

register_command(illusionmob, 
    array(
        description: 'Power',
        permission: 'ch.alias.illusion',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 3) {
                return(false)
            }
            
            @player = player()
            @num = @args[0]
            
            @mobType = @args[1]

            @disguiseType = @args[2]

            @cooldown = 1
            assign(@lastUsedHyenas, import(@player."lastUsedIllusion"))
            if(@lastUsedHyenas + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedHyenas, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can summon Lou and Bud again!'))
                die()
            )
            export(@player."lastUsedIllusion", time() / 1000)

            if(!is_null(import(@player."illusion"))){
                @oldMobs = import(@player."illusion")
                foreach(@uuid in @oldMobs){
                    try(entity_remove(@uuid),
                    continue())
                }
            }
            
            @mobUUIDs = spawn_mob(@mobType,@num)
            export(@player."illusion",@mobUUIDs)
            set_timeout(50,closure(
                sudo('/disguiseradius 1 '.@disguiseType) 
            ))
            
        }
    )
)

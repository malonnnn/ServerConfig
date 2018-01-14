register_command(mindlock, 
    array(
        description: 'Power',
        permission: 'ch.alias.mindlock',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
#            @numArgs = array_size(@args)
            if (array_size(@args) != 1) {
                return(FALSE) 
            }
            
            @vic = @args[0]
            @vic = player(@vic)
            if(!ponline(@vic)){
                die()
            }
            @plr = player()
            
            if(has_permission(@vic,'is.op')){
                tmsg(@plr,color(red).'That player is better than you and cannot be mind locked.')
                die()
            }
            if(has_permission(@vic,"is.telepathicallyresistant")){
                tmsg(@player,color(red)."Sorry, that player is telepathically resistant.")
                die()
            }
            @isMindLocked = import(@vic.'isMindLocked')
            if(@isMindLocked){
                tmsg(@plr,color(red).'That player is already mindlocked')
                die()
            }

            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @ploc = ploc(@plr)
            @vloc = ploc(@vic)
            if(has_permission(@plr,'powers.mindlocknear')){
                @plrClass = _getHeroClass(@plr)
                @radius = 0
                if(@plrClass == 'wonderwoman'){
                    @radius = 20
                }
                if(@ploc['world'] == @vloc['world']){
                    include('/home/minecraft/server/plugins/CommandHelper/includes/distanceBetween.ms')
                    @dist = _distanceBetween(@ploc,@vloc)
                    if(@dist > @radius){
                        tmsg(@plr,color(RED).'Sorry, you are not close enough to that person. Please get within '.@radius.' blocks.')
                        die()
                    }
                }
            }


            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedMindControl',60,@plr)
            
            export(@vic.'isMindLocked',true)
            export(@vic.'mindLockedBy',@plr)

            export(@plr.'isMindLocked',true)
            export(@plr.'mindLockedBy',@vic)
            
            tmsg(@vic,color(red).'You have been mindlocked by '.@plr)
            tmsg(@plr,color(red).'You have mindlocked '.@vic)

            set_timeout(60000,closure(
                @isMindLocked = import(@plr.'isMindLocked')
                if(@isMindLocked){
                    export(@vic.'isMindLocked',false)
                    export(@vic.'mindLockedBy','')
                    export(@plr.'isMindLocked',false)
                    export(@plr.'mindLockedBy','')
                    tmsg(@plr,color(red).'Mindlock connection lost.')
                    tmsg(@vic,color(red).'Mindlock connection lost.')
                }
            ))
            
        }
    )
)

register_command(antivenomattack, 
    array(
        description: 'Power',
        permission: 'powers.antivenomattack',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                return(FALSE) 
            }
            
            @vic = @args[0]
            @vic = player(@vic)

            if(has_permission(@vic,'weakto.antivenom')){
                @ploc = ploc(@sender)
                @vloc = ploc(@vic)
                if(@ploc['world'] == @vloc['world']){
                    include('/home/minecraft/server/plugins/CommandHelper/includes/distanceBetween.ms')
                    @dist = _distanceBetween(@ploc,@vloc)
                    if(@dist > 5){
                        tmsg(@sender,color(RED).'Sorry, you must be within 5 blocks to use this attack on '.color(WHITE).@vic)
                    }else{
                        set_peffect(@vic,20,2,10,TRUE,FALSE)
                        tmsg(@sender,color(RED).'You are burning '.color(WHITE).@vic.color(RED).' with antivenom for 10 seconds!')
                        tmsg(@vic,color(RED).'You are being burned by with Anti-Venom for 10 seconds!')
                    }
                }
            }
        }
    )
)

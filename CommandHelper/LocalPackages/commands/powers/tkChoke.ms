register_command(tkchoke, 
    array(
        description: 'Choke a player',
        permission: 'powers.tkchoke',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /tkchoke <player>');
                return(false)
            }
            
            @vic = @args[0]
            @vic = player(@vic)

            if(has_permission(@vic,'is.criminal')){
                tmsg(@sender,color(red).'You cannot do this to a prisoner')
                die()
            }
            
            include('/home/minecraft/server/plugins/CommandHelper/includes/distanceBetween.ms')
            @dist = _distanceBetween(ploc(@sender),ploc(@vic))
            
            if(@dist < 20){
                include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
                _coolDown('tkChoke',10,@sender)
                sudo('/freeze '.@vic.' 6000')
                sudo(/effect @vic 20 5 6 true)
                sudo(/effect @vic 19 5 6 true)
                broadcast(@sender . " is now telekinetically choking " . @vic)
            )else{
                tmsg(@sender,color(red).'You are not close enough to that player.')
            }
        }
    )
)

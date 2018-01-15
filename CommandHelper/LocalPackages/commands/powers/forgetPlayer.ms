register_command(forget, 
    array(
        description: 'Erase a hero from history',
        permission: 'powers.forget',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 0) {
                return(FALSE) 
            }
            
            @ploc = ploc(@sender)
            @aPlrs = players_in_radius(@ploc,5)
            if(array_size(@aPlrs) >= 2){
                if(@aPlrs[0] == @sender){
                    @vic = @aPlrs[1]
                }else{
                    @vic = @aPlrs[0]
                }
            }else{
                tmsg(@sender,color(red).'Sorry, there is no one close enough!')
                die()
            }

            if(@sender == @vic){
                tmsg(@sender,color(red).'Sorry, this does not work on yourself!')
                die()
            }
            if(has_permission(@vic,'is.criminal')){
                tmsg(@sender,color(red).'Sorry, they are in jail!')
                die()
            }
            
            if(has_permission(@vic,'is.immune')){
                tmsg(@sender,color(red).'Sorry, you cannot do that to them!')
                die()
            }


            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown(@sender.'forgetPlayer',600,@sender)

            
            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @class = _getheroclass(@vic)

            try{
                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@class.'.ms')
                @vicHero = @hero
            }catch(Exception @e){
                @vicHero = array('name': @vic)
            }

            @class = _getheroclass(@sender)
            try{
                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@class.'.ms')
                @plrHero = @hero
            }catch(Exception @e){
                @plrHero = array('name': @sender)
            }

            if(array_index_exists(@vicHero,'alts')){
                @alts = @vicHero['alts']
                array_push(@alts,@vicHero['class'])
                export('forgottenHeroes',@alts)
            }else{
                export('forgottenHeroes',@vicHero['class'])
            }

            runas(@vic,'/mainmenu')

            set_timeout(300000,closure(
                export('forgottenHeroes',null)
            ))

            broadcast(@plrHero['name'].color(RED).' throws '.@vicHero['name'].color(RED).' into The Overvoid! Their memory fades from existence...')
                
        }
    )
)

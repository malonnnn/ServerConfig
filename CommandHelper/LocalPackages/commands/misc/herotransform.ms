register_command(herotransform, 

    array(
        description: 'Transform into a powered up hero',
        usage: '/herotransform <id>',
        permission: 'powers.herotransform',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
                return(false) 
            }
            
            @idToBe = @args[0]
            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')

            @players = all_players()

            foreach(@plr in @players){
                @class = _getheroclass(@plr)
                if(@class == @idToBe){
                    msg(color(RED).'Sorry, '.@plr.' is already '.@idToBe)
                    die()
                }
            }
            @player = player()
            @class = _getheroclass(@player)
            @allowedClasses = false
            @goAhead = false

            if(@class == 'wonderwoman' || 'wonderwomangodmode'){
                @allowedClasses = array('wonderwoman','wonderwomangodmode')
                foreach(@c in @allowedClasses){
                    if(@c == @idToBe){
                        @goAhead = true
                    }
                }
                if(!@goAhead){
                    @msg = color(RED).'wonderwomans transformations are'
                    foreach(@c in @allowedClasses){
                        @msg = @msg.', '.@c
                    }
                    msg(@msg)
                    die()
                }
            }else{
                msg(color(RED).'Sorry, this hero has no transformations')
                die()
            }

            try{
                runas(~console,'/pex user '.@player.' group set '.@idToBe)
                set_timeout(1000,closure(
                    run_cmd('/fixskin')
                ))
                
                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@class.'.ms')
                @oldHero = @hero
                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@idToBe.'.ms')
                @newHero = @hero
                broadcast(color(BLUE).@player.color(GRAY).' has performed a hero transformation from '.@oldHero['name'].color(GRAY).' to '.@newHero['name'].color(GRAY).' !')
            }catch(Exception @e){
                msg(color(RED).'Sorry, that ID cannot be found.')
                die()
            }
        }
    )
)

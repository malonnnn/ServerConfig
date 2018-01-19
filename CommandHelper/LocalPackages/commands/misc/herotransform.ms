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
            @player = player()
            @class = _getheroclass(@player)

            include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@class.'.ms')
            if(!array_index_exists(@hero,'alts')){
                msg(color(RED).'Sorry, your character doesn\'t have any available transformations')
                die()
            }

            @alts = @hero['alts']
            @goAhead = false

            foreach(@alt in @alts){
                if(@alt == @idToBe){
                    @goAhead = true
                }
            }

            if(@goAhead){
        
                runas(~console,'/pex user '.@player.' group set '.@idToBe)
                set_timeout(1000,closure(
                    run_cmd('/fixskin')
                ))
                if(has_permission(@player,'essentials.fly')){
                    run_cmd('/fly on')
                }
                if(has_permission(@player,'ch.alias.buff')){
                    runas(~console,'/minecraft:effect '.@player.' clear')
                    runas(~console,'/minecraft:clear '.@player)
                    runas(@player,'/buff')
                }

                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@class.'.ms')
                @oldHero = @hero
                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@idToBe.'.ms')
                @newHero = @hero
                broadcast(color(BLUE).@player.color(GRAY).' has performed a hero transformation from '.@oldHero['name'].color(GRAY).' to '.@newHero['name'].color(GRAY).' !')

            }else{
                msg(color(RED).'Sorry, the available transformations you have are:')
                foreach(@alt in @alts){
                    msg(@alt)
                }
            }

        }
    )
)

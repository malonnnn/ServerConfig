register_command(herotransform, 

    array(
        description: 'Transform into a powered up hero',
        usage: '/herotransform <id>',
        permission: 'powers.herotransform',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
       
            if(array_size(@args) != 1){
                include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
                @class = _getheroclass(@sender)
                @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
                @hero = yml_decode(@contents)
                @alts = @hero['alts']
                msg(color(RED).'The available transformations you have are:')
                foreach(@alt in @alts){
                    try{
                        @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@alt.'.yml')
                        @hero = yml_decode(@contents)
                        runas(~console,'/tellraw '.@sender.' {"text":"'.@hero['name'].'","color":"gold","clickEvent":{"action":"run_command","value":"/herotransform '.@alt.'"},"hoverEvent":{"action":"show_text","value":"'.@alt.'"}}')
                    }catch(IOException @e){}
                }
                return(false)
            }
 
            @idToBe = @args[0]
            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @player = player()
            @class = _getheroclass(@player)

            @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
            @oldHero = yml_decode(@contents)
            if(!array_index_exists(@oldHero,'alts')){
                msg(color(RED).'Sorry, your character doesn\'t have any available transformations')
                die()
            }

            @alts = @oldHero['alts']
            @goAhead = false

            foreach(@alt in @alts){
                if(@alt == @idToBe){
                    @goAhead = true
                }
            }

            if(@goAhead){
                tmsg(@player,color(GREEN).color(BOLD).'Transforming!')
                @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@idToBe.'.yml')
                @newHero = yml_decode(@contents)
        
                #runas(~console,'/pex user '.@player.' group set '.@idToBe)
                queue_push(closure(runas(~console,'/pex group #'.@idToBe.' delete')))
                queue_push(closure(runas(~console,'/pex group #'.@idToBe.' create')))
                queue_push(closure(runas(~console,'/pex user '.@player.' group set #'.@idToBe)))
                queue_push(closure(runas(~console,'/pex group #'.@idToBe.' parents set #commonherotraits')))
                queue_push(closure(runas(~console,'/pex group #'.@idToBe.' suffix '.@newHero['chatcolor'])))
                @niceName = replace(@newHero['name'],'§','&')
                queue_push(closure(runas(~console,'/pex group #'.@idToBe.' prefix "'.@niceName.'"')))
                foreach(@worldName: @worldPerms in @newHero['permissions']){
                    foreach(@perm in @worldPerms){
                        queue_push(closure(runas(~console,'/pex group #'.@idToBe.' add '.@perm.' '.@worldName)))
                    }
                }
                queue_push(closure(runas(~console,"/fly ".@player." off")))
                queue_push(closure(runas(~console,"/gamemode survival ".@player)))
                queue_push(closure(runas(~console,"/minecraft:clear ".@player)))
                queue_push(closure(set_peffect(@player, 14, 1, 9999, true, false)))
                queue_push(closure(runas(~console,"/god ".@player." off")))
                queue_push(closure(runas(~console,"/tptoggle ".@player." on")))
                
                if(@newHero['trail'] != ''){
                    queue_push(closure(sudo("/trailsid ".@newHero['trail'])))
                }else{
                    queue_push(closure(sudo("/trailsid none")))
                }
                set_timeout(1000,closure(
                    queue_push(closure(run_cmd('/fixskin')))
                ))
                if(has_permission(@player,'essentials.fly')){
                    queue_push(closure(run_cmd('/fly on')))
                }
                queue_push(closure(runas(~console,"/minecraft:effect ".@player." clear")))
                if(has_permission(@player,'ch.alias.buff')){
                    queue_push(closure(runas(@player,'/buff')))
                }

                queue_push(closure(sudo('/powers')))
                queue_push(closure(broadcast(color(BLUE).@player.color(GRAY).' has performed a hero transformation from '.@oldHero['name'].color(GRAY).' to '.@newHero['name'].color(GRAY).' !')))

            }else{
                msg(color(RED).'Sorry, the available transformations you have are:')
                foreach(@alt in @alts){
                    try{
                        @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@alt.'.yml')
                        @hero = yml_decode(@contents)
                        queue_push(closure(runas(~console,'/tellraw '.@sender.' {"text":"'.@hero['name'].'","color":"gold","clickEvent":{"action":"run_command","value":"/herotransform '.@alt.'"},"hoverEvent":{"action":"show_text","value":"'.@alt.'"}}')))
                    }catch(IOException @e){}
                }
            }

        }
    )
)

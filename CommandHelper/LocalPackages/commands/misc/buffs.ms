register_command(buff, 
    array(
        description: 'Gives Player their Superhero Powers',
        usage: '/buff',
        permission: 'ch.alias.buff',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {
        
            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @plr = player()
            @class = _getheroclass(@plr)
          
            try {
                @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
                @hero = yml_decode(@contents)
                
            } catch (IOException @ErrorInfo) {
                tmsg(@plr, 'There\'s no buffs\'s associated with your current Character Class')
                die()
            }
            if(array_index_exists(@hero,'buffs')){
                foreach(@power in @hero['buffs']){
                    @power = replace(@power,'<plr>',@plr)
                    queue_push(closure(runas(~console,@power)))
                }
            }

#            queue_push(closure(
#                @pinv = pinv(@plr)
#                @i = 0
#                foreach(@slot: @itm in @pinv){
#                    if(@itm != null){
#                        queue_push(closure(runas(~console,'/nbt *'.@plr.' Inventory['.@i.'].tag += {heroclass:'.@hero['class'].'}')))
#                        @i++
#                    }
#                }
#            ))

            if(array_index_exists(@hero,'maxHearts')){
                @puuid = puuid(@plr)
                queue_push(closure(set_attribute(@puuid,'maxHealth',@hero['maxHearts'])))
                queue_push(closure(set_phealth(@plr,@hero['maxHearts'])))
            }
            queue_push(closure(set_phunger(@plr,17)))
            queue_push(closure(tmsg(@plr,@hero['speech'])))
        }
    )
)
#            if(array_index_exists(@hero,'buffs')){
#                queue_push(closure(runas(~console,'/minecraft:effect '.@plr.' clear')))
#                foreach(@power in @hero['buffs']){
#                    if(string_position(@power,'/e') != -1){
#                        @powNum = reg_match('(\\w+) 9999',@power)[1]
#                        @powAmp = reg_match('9999 (\\w+)',@power)[1]
#                        #@powNum = reg_match('(?<foo>\w+) 9999',@power)
#                        #@powAmp = reg_match('9999 (?<foo>\w+)',@power)
#                        @power = replace(@power,'<plr>',@plr)
#                        console('powNum: '.@powNum)
#                        console('powAmp: '.@powAmp)
#                        queue_push(closure(set_peffect(@plr,@powNum,@powAmp,9999,true,false)))
#                    }else{
#                        @power = replace(@power,'<plr>',@plr)
#                        queue_push(closure(runas(~console,@power)))
#                    }
#                }
#                queue_push(closure(
#                    @puuid = puuid(@plr)
#                    @maxHealth = get_max_health(@puuid)
#                    set_timeout(1000,closure(
#                        queue_push(closure(set_phealth(@plr,@maxHealth)))
#                    ))
#                ))
#                queue_push(closure(set_phunger(@plr,17)))
#                queue_push(closure(tmsg(@plr,@hero['speech'])))

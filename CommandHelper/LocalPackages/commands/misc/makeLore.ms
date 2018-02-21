register_command(getnbt, 
    array(
        description: 'Gives Player their Superhero Powers',
        usage: '/getnbt',
        permission: 'command.makelore',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alises, @sender, @args) {
        
            @vic = @args[0]
            @slot = @args[1]
            console(nbt_read_inventory_item(puuid(@vic),@slot))
        }
    )
)
register_command(makelore, 
    array(
        description: 'Gives Player their Superhero Powers',
        usage: '/makelore',
        permission: 'command.makelore',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alises, @sender, @args) {
        
            @lore = @args[0]

            @item = pinv(@sender, null)
            @item['meta'] = array('lore': '')
            @item['meta']['lore'] = @lore
            set_pinv(array(null: @item))

        }
    )
)
register_command(addtolore, 
    array(
        description: 'Gives Player their Superhero Powers',
        usage: '/makelore',
        permission: 'command.makelore',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alises, @sender, @args) {
        
            @lore = @args[0]

            @item = pinv(@sender, null)
            @existingLore = ''
            if(@item['meta'] != null && array_index_exists(@item['meta'],'lore')){
                array_push(@item['meta']['lore'],@lore)
            }else{
                @item['meta'] = array('lore': array(@lore))
            }
            set_pinv(array(null: @item))

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

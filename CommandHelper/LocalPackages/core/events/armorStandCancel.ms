bind(hanging_break,null,array('type': '/ITEM_FRAME|PAINTING/'),@e){
        cancel()
        if(@e['player'] != null && has_permission(@e['player'],'cancel.entityclicks') == false){
            console('dead from hanging break')
            console(@e['location'])
            entity_remove(@e['id'])
            die()
        }else if(@e['cause'] == 'PHYSICS'){
            entity_remove(@e['id'])
            if(@e['type'] == 'PAINTING'){
                @num = '321'
            }else{
                @num = '389'
            }
            @item = array('type':@num, 'data':0, 'qty': 1)
            console(@e)
 
            drop_item(@e['location'],@item)
        }
}
bind(player_interact_at_entity,null,null,@e){
    if(has_permission('cancel.entityclicks') == false){
        console('dead from player interact at entity')
        console(@e['player'])
        die()
    }
    cancel()
}
bind(player_interact_entity,null,array('clicked':'ITEM_FRAME'),@e){
    if(has_permission('cancel.entityclicks') == false){
        console('dead from player interact')
        console(@e['player'])
        die()
    }
    cancel()
}
bind(entity_damage,null,array('type':'/ARMOR_STAND|ITEM_FRAME|PAINTING|MINECART|CHEST_MINECART|TNT_MINECART|FURNACE_MINECART|HOPPER_MINECART/'),@e){
    cancel()
    if(array_index_exists(@e,'damager')){
        if(has_permission(@e['damager'],'cancel.entityclicks') == false){
            console('dead from damage entity')
            console(@e['location'])
            entity_remove(@e['id'])
            die()
        }
    }
}
bind(vehicle_destroy,null,null,@e){
    include('/home/minecraft/server/plugins/CommandHelper/includes/isWorldExplorable.ms')
    if(_isWorldExplorable(@e['location']['world'])){
        cancel()
    }
    if(array_index_exists(@e, 'damager') && has_permission(@e['damager'],'cancel.entityclicks') == false){
        console('dead from vehicle destroy')
        entity_remove(@e['vehicle'])
        console(@e['location'])
        die()
    }
}
bind(block_dispense,null,null,@e){
    include('/home/minecraft/server/plugins/CommandHelper/includes/isWorldExplorable.ms')
    if(_isWorldExplorable(@e['location']['world'])){
        cancel()
    }
}

bind(inventory_drag,null,null,@e){
    if(@e['oldcursoritem']['type'] == '397'){
        foreach(@slot in @e['slots']){
            console(@slot)
            if(@slot == 39){
                cancel()
                return()
            }
        }
    }
}

bind(inventory_click,null,null,@e){
#        if(@e['rawslot'] >= @e['inventorysize']){
#            #local inventory
#            @nbt = nbt_read_inventory_item(puuid(@e['player']),@e['slot'])
#            console(@e['player'].' - '.@e['slot'])
#        }else{
#            console('remote inv, dont care')
#            die()
#        }
#        if(@e['player'] == 'Jiren_The_Grey'){
#            console(@e)
#            die()
#        }
#        die()
#        if(@e['cursoritem'] != null){
#            console('1')
#            if(@e['player'] == 'Jiren_The_Grey' && @e['rawslot'] >= @e['inventorysize']){
#                console('2')
#                #local inventory
#                #@nbt = nbt_read_inventory_item(puuid(@e['player']),@e['rawslot'])
#                @nbt = array()
#                if(array_index_exists(@nbt,'heroclass')){
#                    console('3')
#                    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
#                    @class = _getheroclass(@e['player'])
#                    try {
#                        @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
#                        @hero = yml_decode(@contents)
#                        console('4')
#                    } catch (IOException @ErrorInfo) {
#                        modify_event('cursoritem', null)
#                        console('5 '.@ErrorInfo.' - '.@class)
#                        die()
#                    }
#                    if(@nbt['heroclass'] != @hero['class']){
#                        modify_event('cursoritem', null)
#                        console('6')
#                        die()
#                    }
#                }
#            }
#        }
        if(@e['slotitem'] != null){
#            console('slotitem is here')
#            if(@e['rawslot'] >= @e['inventorysize']){
#                #local inventory
#                @nbt = nbt_read_inventory_item(puuid(@e['player']),@e['slot'])
#            }else{
#                @nbt = nbt_read_inventory_item(puuid(@e['player']),@e['rawslot'])
#            }
#            if(array_index_exists(@nbt,'heroclass')){
#                include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
#                @class = _getheroclass(@e['player'])
#                try {
#                    @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
#                    @hero = yml_decode(@contents)
#                } catch (IOException @ErrorInfo) {
#                    modify_event('slotitem', null)
#                    die()
#                }
#                if(@nbt['heroclass'] != @hero['class']){
#                    modify_event('slotitem', null)
#                    die()
#                }
#            }
            if(@e['slotitem']['type'] == '397' && @e['shiftclick'] == true){
                cancel()
            }
            if(array_index_exists(@e['slotitem'],'enchants')){
                foreach(@enchant in @e['slotitem']['enchants']){
                    if(@enchant['etype'] == 'FROST_WALKER'){
                        modify_event('slotitem',null)
                        tmsg(@e['player'], color(RED).'Sorry, frost walker is not allowed, that item has been removed.')
                    }
                }
            }
        }else{
            if(array_index_exists(@e,'cursoritem')){
                if(array_index_exists(@e,'slottype')){
                    if(@e['cursoritem']['type'] == '397' && @e['slottype'] == 'ARMOR'){
                        cancel()
                    }
                }
            }
        }
}
bind(player_interact, null, array(button: 'right'), @e){
    if(@e['action'] == 'right_click_air'){
        @meta = get_itemmeta(@e['player'], null)
        if(@meta != null && is_array(@meta['enchants'])){
            @item = pinv(@e['player'],null)
            if(@item['type'] == '397'){
                cancel()
            }
            if(@item['type'] == 301 || @item['type'] == 305 || @item['type'] == 309 || @item['type'] == 313 || @item['type'] == 317){
                foreach(@enchant in @meta['enchants']){
                    if(@enchant['etype'] == 'FROST_WALKER'){
                        @enchant['elevel'] = 0
                    }
                }
                set_itemmeta(@e['player'], null, @meta)
            }
        }
    }
}
#bind(inventory_open,null,null,@e){
#    if(has_permission('cancel.entityclicks') && !has_permission('is.op')){
#        cancel()
#    }
#}

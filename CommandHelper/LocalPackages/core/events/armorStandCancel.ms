bind(hanging_break,null,array('type': '/ITEM_FRAME|PAINTING/'),@e){
        cancel()
        if(array_index_exists(@e,'player') && has_permission(@e['player'],'cancel.entityclicks') == false){
            console('dead from hanging break')
            entity_remove(@e['id'])
            die()
        }
}
bind(player_interact_at_entity,null,null,@e){
    if(has_permission('cancel.entityclicks') == false){
        console('dead from player interact at entity')
        die()
    }
    cancel()
}
bind(player_interact_entity,null,array('clicked':'ITEM_FRAME'),@e){
    if(has_permission('cancel.entityclicks') == false){
        console('dead from player interact')
        die()
    }
    cancel()
}
bind(entity_damage,null,array('type':'/ARMOR_STAND|ITEM_FRAME|PAINTING|MINECART|CHEST_MINECART|TNT_MINECART|FURNACE_MINECART|HOPPER_MINECART/'),@e){
    cancel()
    if(array_index_exists(@e,'damager')){
        if(has_permission(@e['damager'],'cancel.entityclicks') == false){
            console('dead from damage entity')
            entity_remove(@e[''])
            die()
        }
    }
}
bind(vehicle_destroy,null,null,@e){
    cancel()
    if(array_index_exists(@e, 'damager') && has_permission(@e['damager'],'cancel.entityclicks') == false){
        console('dead from vehicle destroy')
        die()
    }
}
#bind(inventory_open,null,null,@e){
#    if(has_permission('cancel.entityclicks') && !has_permission('is.op')){
#        cancel()
#    }
#}

#bind(item_drop,null,null,@e){
#    #@item = @e['item']
#    #if(@e['player'] == 'Jiren_The_Grey'){
#        #queue_push(closure(runas(~console,'/nbt @'.@plr.' Inventory['.@slot.'].tag += {heroclass:'.@hero['class'].'}')))
        #console(@nbt)
#    }
#    if(@item['meta'] == null || @item['meta']['lore'] == null){
#        die()
#    }
#    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
#    @class = _getheroclass(@e['player'])
#    try {
#        @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
#        @hero = yml_decode(@contents)
#    } catch (IOException @ErrorInfo) {
#        # if the item has lore but the player isn't a hero, erase item from the world on pickup
#        modify_event('item', null)
#        die()
#    }
#    if(@item['meta']['lore'][0] != @hero['class']){
#        # if the item belongs to another hero, erase item from the world on pickup
#        modify_event('item', null)
#    }
#}

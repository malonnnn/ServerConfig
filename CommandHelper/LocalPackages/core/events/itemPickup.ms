#bind(item_pickup,null,null,@e){
#    @nbt = nbt_read_entity(@e['id'])
#    if(!array_index_exists(@nbt,'Item') || !array_index_exists(@nbt['Item'],'tag') || !array_index_exists(@nbt['Item']['tag'],'heroclass')){
#        if(@e['player'] == 'Jiren_The_Grey'){
#            console(@nbt)
#        }
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
#    if(@nbt['Item']['tag']['heroclass'] != @hero['class']){
#        # if the item belongs to another hero, erase item from the world on pickup
#        modify_event('item', null)
#    }
#}

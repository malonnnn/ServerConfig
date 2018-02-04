bind(entity_explode,null,null,@e){
    include('/home/minecraft/server/plugins/CommandHelper/includes/isWorldExplorable.ms')
    if(_isWorldExplorable(@e['location']['world'])){
        cancel()
    }
}

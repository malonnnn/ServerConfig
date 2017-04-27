bind(entity_death,null,null,@event){

    if(@event['type'] == 'SKELETON' && array_index_exists(@event['cause'],'damager') && ponline(@event['cause']['damager']) && @event['cause']['world'] == 'greenfield'){
        @plr = @event['cause']['damager']
        runas(~console,"/eco give ".@plr." 1")
        tmsg(@plr,color(green)."+1 ".color(dark_green)."seconds earned for OP heroes")
    }

}

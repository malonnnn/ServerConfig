bind(entity_death,null,null,@event){

    if(@event['type'] == 'SKELETON' &&  ponline(@event['cause']['damager']) && @event['cause']['world'] == 'greenfield'){
        runas(~console,"/eco give ".@event['cause']['damager']." 1")
    }

}

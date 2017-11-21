register_command(throwironswords, 
    array(
        description: 'Power',
        permission: 'powers.throwironswords',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {        
            
            @player = player()
            @pcursor = pcursor(@player)

            @feather = shoot_projectile(@player,'ARROW',@pcursor,2.0)

            @featherVelocity = entity_velocity(@feather)
            @featherLocation = entity_loc(@feather)

            entity_remove(@feather)
            @feath = drop_item(@featherLocation,array('type':'267'),false)
            set_entity_velocity(@feath,@featherVelocity)

            export(@player.'archAngelFeather',@feath)
            export(@player.'archAngelFeatherPos',array('x':'','y':'','z':''))

            bind(){

            }

            set_interval(50,closure(
                @feath = import(@player.'archAngelFeather')
                @oldPos = import(@player.'archAngelFeatherPos')
                try{
                    @newPos = entity_loc(@feath)
                }catch(Exception @e){
                    clear_task()
                }
                if(
                    @oldPos['x'] == @newPos['x'] &&
                    @oldPos['z'] == @newPos['z']
                ){
                    clear_task()
                    entity_remove(@feath)
                }else{
                    export(@player.'archAngelFeatherPos',@newPos)
                }
            ))

        }
    )
)
#register_command(throwironswords, 
#    array(
#        description: 'Power',
#        permission: 'powers.throwironswords',
#        noPermMsg: 'Sorry you don\'t have permission to use this command.',
#        executor: closure() {        
#            
#            @magnitude = 2; // speed of falling block
#            @damage = 50; // amount of damage the block will do to other players
#
#            // get the starting location
#            @loc = ploc();
#            @loc['y'] += 2; // chest height
#
#            // get the vector from player yaw/pitch
#            @yaw = @loc['yaw'] + 90;
#            @pitch = neg(@loc['pitch']);
#            @vector = associative_array();
#            @vector['x'] = @magnitude * (cos(to_radians(@yaw)) * cos(to_radians(@pitch)));
#            @vector['y'] = @magnitude * sin(to_radians(@pitch));
#            @vector['z'] = @magnitude * (sin(to_radians(@yaw)) * cos(to_radians(@pitch)));
#
#            @id = spawn_falling_block(@loc, 42, @vector);
#
#            #@var = 0
#            #export('var',@var)
#
#            bind(entity_change_block, associative_array('id': 'magneto'.@id), associative_array('to': 42), 
#                    @event, @id, @damage, @player = player()) {
#                        
#            #            @loc = entity_loc(@id);
#            #            drop_item(@loc,array(type: 42, qty: 1))
#                        cancel()
#                        
#            }
#
#            set_interval(50, closure(){
#                try {
#                    #@var = import('var')
#                    #if(@var < 3){
#                    #    @var = @var +1
#                    #    export('var',@var)
#                    #    return()
#                    #}
#                    @loc = entity_loc(@id);
#                    @loc['y'] -= 1; // so we detect if the block is at player chest height
#                    foreach(@p in entities_in_radius(@loc, 3)) {
#                        // apply damage to player's UUID and attribute it to current player
#                        if(is_entity_living(@p)){
#                            damage_entity(puuid(@p), @damage, puuid());
#                        }
#                    }
#                } catch(Exception @ex) {
#                    // entity no longer exists, clear the interval
#                    clear_task();
#                    // unbind the landing event
#                    unbind('magneto'.@id);
#                }});
#                
#        }
#    )
#)

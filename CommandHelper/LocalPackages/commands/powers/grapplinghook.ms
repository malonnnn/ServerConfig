register_command('grapplinghook', 

    array(
        description: 'Fires a grappling hook',
        usage: '/grapplinghook',
        permission: 'powers.grapplinghook',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        tabcompleter: closure(@alias, @sender, @args) {
            try{
                if(array_size(@args) == 0){
                    return(all_players())
                }
                @search = @args[array_size(@args) - 1];
                    return(array_filter(all_players(), closure(@index, @player) {
                    return(equals_ic(@search, substr(@player, 0, length(@search))));
                }));
            } catch (RangeException @ErrorInfo) {
                # Ignore
            }
        },
    
        executor: closure(@alias, @sender, @args) {
  
            assign(@cooldown, 7)

            assign(@lastgrapplinghook, import('lastgrapplinghook'))
            if(@lastgrapplinghook + @cooldown > time() / 1000){
                msg(color(RED).'Sorry, the cooldown for this is '.@cooldown.' seconds')
                die()
            }
            export('lastgrapplinghook', time() / 1000)
          
            @multiplier = 0.5
            @arrow = shoot_projectile(player(), 'ARROW')
            @velocity = entity_velocity(@arrow)
            
            # spawn pig
            @ploc = ploc()
            @ploc['y']  = @ploc['y'] + 1
            @pig = spawn_entity("CHICKEN", 1, @ploc)[0]
            
            try{
                set_mob_effect(@pig, 14, 1, 9999, true, false)
            }catch(Exception @e){
                tmsg(player(), "Sorry, you can't use grapplinghook in here")
                entity_remove(@arrow)
                die()
            }
            
            # set pig invisible
            set_mob_effect(@pig, 11, 254, 9999, true, false)
            
            # sit player on pig
            set_entity_rider(@pig, puuid(player(),true))
            set_leashholder(@pig,@arrow)
            set_entity_velocity(@arrow, array(@velocity['x'] * @multiplier, @velocity['y'] * @multiplier, @velocity['z'] * @multiplier))

                
            bind(projectile_hit, null, array(type: 'ARROW', shootertype: 'PLAYER', id: @arrow), @event, @arrow, @pig) {
                
                set_timeout(5000, closure(){
                    entity_remove(@pig)
                    entity_remove(@arrow)
                });
                unbind()
            }
        }
    )
)

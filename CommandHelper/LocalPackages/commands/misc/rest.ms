register_command(rest, 
    array(
        description: 'Power',
        permission: 'command.rest',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@aliases, @sender, @args) {

            if(import(@sender.'isResting') == true){
                msg(color(RED).'You are already resting.')
                die()
            }
            export(@sender.'isResting',true)

            set_peffect(@sender,10,1,9999,true,false)
            bind(player_move,array('id': @sender.'restMove'),array('player': @sender),@event,@sender){
                unbind()
                unbind(@sender.'restDamage')
                unbind(@sender.'restQuit')
                set_peffect(@sender,10,0,0,true,false)
                export(@sender.'isResting',false)
                msg(color(RED).'You are no longer resting.')
            }
            bind(entity_damage_player,array('id': @sender.'restDamage'),array('player': @sender),@event,@sender){
                unbind()
                unbind(@sender.'restMove')
                unbind(@sender.'restQuit')
                unbind(@sender.'restDamage')
                set_peffect(@sender,10,0,0,true,false)
                export(@sender.'isResting',false)
                msg(color(RED).'You are no longer resting.')
            }
            bind(player_quit,array('id': @sender.'restQuit'),array('player': @sender),@event,@sender){
                unbind()
                unbind(@sender.'restMove')
                unbind(@sender.'restDamage')
                set_peffect(@sender,10,0,0,true,false)
                export(@sender.'isResting',false)
                msg(color(RED).'You are no longer resting.')
            }
            msg(color(RED).'You are now resting.')
        }
    )
)

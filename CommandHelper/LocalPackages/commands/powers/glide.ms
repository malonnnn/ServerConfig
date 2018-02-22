register_command(glide, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.glide',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        tabcompleter: closure(@alias, @sender, @args) {
        
        @p = player()
        
        msg(color(GREEN).'You are now gliding!')
        set_peffect(25, 250, 10000, true, false)
        }
          if(entity_grounded(@p) != true)
          return(TRUE)
          }
          if(true = true){print{"You can not use this command right now!"}}
          }
          include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
          _coolDown('lastUsedMindControl',60,@player)
          {
       {
   )
)
     
          
          
            

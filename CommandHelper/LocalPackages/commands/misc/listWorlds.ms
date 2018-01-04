#register_command(listworlds, 
#    array(
#        description: 'Selects a stage',
#        usage: '/listworlds <pageNum>',
#        permission: 'ch.alias.listworlds',
#        noPermMsg: 'Sorry you don\'t have permission to use this command.',		
#        executor: closure(@alias, @sender, @args) {
#
#            @pageNum = @args[0]
#            
#            if(@pageNum < 1){
#                die()
#            }
#            
#            @startSpot = @pageNum * 10 - 9
#            include('/home/minecraft/server/plugins/CommandHelper/includes/worldList.ms') 
#            @i = @startSpot
#            foreach(@world in @worldList){
#                tmsg(player(),"#". @i . ". " . @world[1])
#                @i = @i + 1
#            }
#        }
#    )
#)
#
#register_command(listworlds, 
#    array(
#        description: 'Selects a stage',
#        usage: '/listworlds',
#        permission: 'ch.alias.listworlds',
#        noPermMsg: 'Sorry you don\'t have permission to use this command.',		
#        executor: closure(@alias, @sender, @args) {
#
#            include('/home/minecraft/server/plugins/CommandHelper/includes/worldList.ms') 
#            @i = 1
#            @plr = player()
#            foreach(@world in @worldList){
#                tmsg(@plr,'#'.@i.'. '.@world[1])
#                @i = @i + 1
#            }
#        }
#    )
#)



register_command(stageselect, 
    array(
        description: 'Selects a stage',
        usage: '/stageselect',
        permission: 'command.stageselect',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',		
        executor: closure(@alias, @sender, @args) {
                @argNum = array_size(@args)
                if (@argNum != 0) {
                    msg(color(RED).'Try this: /stageselect')
                    return(FALSE)
                }

                include('/home/minecraft/server/plugins/CommandHelper/includes/worldList.ms') 
                foreach(@world in @worldList){
                    runas(~console,'/tellraw '.@sender.' {"text":"'.@world[1].'","clickEvent":{"action":"run_command","value":"/warp '.@world[0].'"}}')
                }
                msg(color(RED).'Click a stage to go there.')
       ) }
    )



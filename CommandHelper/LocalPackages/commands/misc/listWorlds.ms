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
        aliases: array('stagesel', 'findstage','ssel'),
        executor: closure(@alias, @sender, @args) {
                @argNum = array_size(@args)
                if (@argNum != 0) {
                    msg(color(RED).'Try this: /stageselect')
                    return(FALSE)
                }

                include('/home/minecraft/server/plugins/CommandHelper/includes/worldList.ms') 
                foreach(@world in @worldList){
                    runas(~console,'/tellraw '.@sender.' {"text":"'.@world[1].'","clickEvent":{"action":"run_command","value":"/goworld '.@world[0].'"}}')
                }
                msg(color(RED).'Click a stage to go there.')
       ) }
    )


register_command(goworld, 
    array(
        description: 'Goes to stage',
        usage: '/goworld',
        permission: 'command.stageselect',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',		
        executor: closure(@alias, @sender, @args) {
            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @class = _getheroclass(@sender)
            try{
                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@class.'.ms')
            }catch(Exception @d){
                @hero = array()
                @hero['name'] = @sender
            } 
            runas(~console,'/warp '.@args[0].' '.@sender)
            broadcast(color(BLUE).@hero['name'].color(GRAY).color(ITALIC).' has entered the game!')
            set_timeout(2000,closure(
                sudo('/buff')
                msg(color(RED).'Check out your '.color(GREEN).'/powers'.color(RED).' !')
            ))
        }
    )
)

register_command(listheroes, 

    array(
    
        description: 'Lists the Super Heroes available on the Server',
        
        usage: '/listheroes [page number]',
        
        permission: 'ch.alias.listheroes',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',		
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) > 1) {
                
                    msg(''.color(RED).color(BOLD).'Improper Usage!');
                    msg(''.color(RED).'Usage: /listheroes [page number]');
                    die(); # No need to go further					
                
                } else if (array_size(@args) == 1) {
                
                    @pageNum = @args[0]
                
                } else {
                
                    @pageNum = null
                
                }
        
                if(@pageNum < 1 && @pageNum != null){
                    msg(''.color(RED).color(BOLD).'There is no page Zero');
                    die()
                }
                
                @stdout = ""
                
                if (@pageNum != null){
                    @startSpot = @pageNum * 10 - 9
                    
                    shell_adv('/home/minecraft/paginateHeroes.sh '. @startSpot,
                    array(subshell: true,
                        workingDir: '/home/minecraft/',
                        stdout: closure(@a = @stdout){
                            if(@a != "")
                            {
                                @returnVal = @a
                                array @heroes = split('|',@returnVal)
                                @i = @startSpot
                                foreach(@her in @heroes){
                                    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @her . '.ms')
                                    tmsg(player(),"#". @i . ". " . @hero['name'])
                                    @i = @i + 1
                                }
                            }
                        }
                    ))
                } else {
                
                    shell_adv('/home/minecraft/paginateHeroes.sh 1',
                    array(subshell: true,
                        workingDir: '/home/minecraft/',
                        stdout: closure(@a = @stdout){
                            if(@a != "")
                            {
                                @returnVal = @a
                                array @heroes = split('|',@returnVal)
                                @i = 1
                                foreach(@her in @heroes){
                                    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @her . '.ms')
                                    tmsg(player(),"#". @i . ". " . @hero['name'])
                                    @i = @i + 1
                                }
                            }
                        }
                    ))
                    
                }				
        
        }
    )
)

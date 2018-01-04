register_command(heroes, 
    array(
        description: 'Lists the Super Heroes available on the Server',
        usage: '/listheroes [page number]',
        permission: 'ch.alias.listheroes',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',		
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) > 1) {
                    return(FALSE)
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
                                msg(color(RED).'Check for more heroes using /heroes '.(@pageNum+1))
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
                                msg(color(RED).'Check for more heroes using /heroes 2')
                            }
                        }
                    ))
                    
                }				
        
        }
    )
)


register_command(findchar, 
    array(
        description: 'Searches for a character',
        usage: '/findchar <searchterm>',
        permission: 'command.findchar',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',		
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) < 1) {
                    msg(color(RED).'Please add search criteria. Example: /findhero superman')
                    return(FALSE)
                }

                @searchTerm = ''
                foreach(@arg in @args){
                    @searchTerm = @searchTerm.@arg
                }

                shell_adv('/home/minecraft/findHero.sh '.@searchTerm,
                array(subshell: true,
                    workingDir: '/home/minecraft/',
                    stdout: closure(@a = @stdout){
                        if(@a != "")
                        {
                            @returnVal = @a
                            array @heroes = split('|',@returnVal)
                            foreach(@her in @heroes){
                                run_cmd('/id '.@her)
                            }
                        }
                    }
                ))
       ) }
    )



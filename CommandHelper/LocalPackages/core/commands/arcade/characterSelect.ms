register_command(chars, 
    array(
        description: 'Lists the Super Heroes available on the Server',
        usage: '/chars [page number]',
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
                                    #tmsg(player(),"#". @i . ". " . @hero['name'])
                                    #tmsg(player(),@hero['name'])
                                    runas(~console,'/tellraw '.@sender.' {"text":"'.@hero['name'].'","color":"gold","clickEvent":{"action":"run_command","value":"/selectchar '.@her.'"},"hoverEvent":{"action":"show_text","value":"'.@her.'"}}')
                                    #@i = @i + 1
                                }
                                msg(color(RED).'Click a character 2 times to choose it or')
                                msg(color(RED).'Check for more heroes using '.color(GREEN).color(BOLD).'/chars '.(@pageNum+1))
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
                                    #tmsg(player(),"#". @i . ". " . @hero['name'])
                                    #@i = @i + 1
                                    runas(~console,'/tellraw '.@sender.' {"text":"'.@hero['name'].'","color":"gold","clickEvent":{"action":"run_command","value":"/selectchar '.@her.'"},"hoverEvent":{"action":"show_text","value":"'.@her.'"}}')
                                }
                                msg(color(RED).'Click a character 2 times to choose it or')
                                msg(color(RED).'Check for more heroes using '.color(GREEN).color(BOLD).'/chars 2')
                            }
                        }
                    ))
                    
                }				
        
        }
    )
)


register_command(characterselect, 
    array(
        description: 'Searches for a character',
        usage: '/characterselect <searchterm>',
        permission: 'command.characterselect',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',		
        aliases: array('charsel', 'findchar','csel'),
        executor: closure(@alias, @sender, @args) {
            @argNum = array_size(@args)
            if (@argNum < 1) {
                msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
                msg(color(RED).'Please search for a character.')
                msg('Example:'.color(GREEN).' /findchar wonder woman')
                msg('Example:'.color(GREEN).' /findchar Captain America')
                msg('Example:'.color(GREEN).' /findchar greenlantern')
                msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
                return(FALSE)
            }
            @ploc = ploc(@sender)
            @ploc2 = array(x: -76, y: 248, z: 132) 

            include('/home/minecraft/server/plugins/CommandHelper/includes/distanceBetween.ms')
            @final = _distanceBetween(@ploc,@ploc2)
            
            if(@final > 5){
                msg(color(RED).'Sorry, you need to be at the main menu to perform this command!')
                die()
            }

            @searchTerm = ''
            foreach(@arg in @args){
                @searchTerm = @searchTerm.@arg
            }
            @heroes = array()

            @var = shell('find /home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/ -iname \"*'.@searchTerm.'*\" -exec basename \\{} .ms \\;')
            @heroes = split('\n',@var)
            msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
            @foundAHero = true
            foreach(@her in @heroes){
                try{
                    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.replace(@her,'\n','').'.ms')
                    runas(~console,'/tellraw '.@sender.' {"text":"'.@hero['name'].'","color":"gold","clickEvent":{"action":"run_command","value":"/selectchar '.@her.'"},"hoverEvent":{"action":"show_text","value":"'.@her.'"}}')
                }catch(IOException @e){
                    @foundAHero = false
                    break()
                }
            }
            if(@foundAHero){
                msg(color(RED).'Click a character to select it.')
            }else{
                msg(color(RED).'Sorry, we don\'t have that character yet :(')
                msg(color(RED).'You can add it to the server by watching the following videos:')
                msg(color(RED).'Please note, only the 1st 3 videos are required, the rest are optional.')
                msg(color(GREEN).'http://mynecraft.servegame.com/howtomakeahero.html')
            }
            msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
       ) }
    )


register_command(selectchar, 
    array(
        description: 'Selects a character',
        usage: '/selectchar <character>',
        permission: 'command.selectchar',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',		
        executor: closure(@alias, @sender, @args) {
                @argNum = array_size(@args)
                if (@argNum != 1) {
                    msg(color(RED).'Error: Incorrect parameters. Try: /selectchar superman')
                    return(FALSE)
                }

                @player = @sender
                @ploc = ploc(@player)
                @center = array('x': -76.5, 'y': 249, 'z': 132, 'world': @ploc['world'])

                @x1 = @ploc['x']
                @y1 = @ploc['y']
                @z1 = @ploc['z']

                @x2 = @center['x']
                @y2 = @center['y']
                @z2 = @center['z']

                @x3 = pow(@x1 - @x2, 2)
                @y3 = pow(@y1 - @y2, 2)
                @z3 = pow(@z1 - @z2, 2)

                @final = @x3 + @y3 + @z3

                @final = sqrt(@final)
                
                if(@final > 5){
                    msg(color(RED).'Sorry, you need to be at the main menu to perform this command!')
                    die()
                }
                @class = @args[0]
                @confirmed = import(@player."charConfirmed")
                if(@confirmed != @class){
                    export(@player."charConfirmed",@class)
                    msg(@class.color(RED).' selected! Please click again to confirm your choice.')
                    die()
                }
                @forgottenHeroes = import('forgottenHeroes')
                if(@forgottenHeroes != null){
                    if(is_array(@forgottenHeroes)){
                        foreach(@fhero in @forgottenHeroes){
                            if(@fhero == @class){
                                msg(color(RED).'Sorry, that hero is currently locked. Please check back later.')
                                die()
                            }
                        }
                    }else{
                        if(@forgottenHeroes == @class){
                            msg(color(RED).'Sorry, that hero is currently locked. Please check back later.')
                            die()
                        }
                    }
                }
                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms')
                @plrs = all_players()
                include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
                foreach(@playa in @plrs)
                {
                    @otherPlayerGroup = _getheroclass(@playa)
                    if(@otherPlayerGroup == @hero['class'] && @player != @playa){
                        msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
                        msg(color(RED).'Sorry, '.color(WHITE).@playa.color(RED).' is already using '.@hero['name'].color(RED).'.')
                        msg(color(DARK_RED).'Please choose a different character.')
                        msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
                        die()
                    }
                    if(array_index_exists(@hero,'alts')){
                        @alts = @hero['alts']
                        foreach(@alt in @alts){
                            if(@alt == @otherPlayerGroup){
                                @h1 = @hero['name']
                                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @alt . '.ms')
                                @h2 = @hero['name']
                                msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
                                msg(color(RED).'Sorry, '.color(WHITE).@playa.color(RED).' is already using '.@h2.color(RED).'.')
                                msg(color(RED).'Try again with:')
                                msg(color(GREEN).'/characterselect')
                                msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
                                die()
                            }
                        } 
                    }
                }
                clear_task(import(@player.'isBurningInSunlight'))
                export(@player.'skinNum',1)
                if(@class == 'fanfic'){
                    @uuid = puuid(@player,true)
                    sudo('/pex group '.@class.@uuid.' create commonherotraits')
                    sudo('/pex user '.@player.' group set '.@class.@uuid)
                    sudo('/pex group '.@class.@uuid.' add ch.alias.run0 superherocity')
                    sudo( '/pex group '.@class.@uuid.' add ch.alias.run1 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.run2 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.haste0 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.haste1 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.haste2 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.jump0 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.jump1 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.jump2 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.fanficlaser superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.fanficname superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.fanficchatcolor superherocity')
                    sudo('/pex group '.@class.@uuid.' add is.fanfic superherocity')
                    broadcast(color(GRAY).color(ITALIC).'A shitty fanfic has entered the game!')
                    sudo("/fly ".@player." off")
                    sudo("/gamemode survival ".@player)
                    sudo("/effect ".@player." clear")
                    sudo("/minecraft:clear" @player)
                    sudo("/god ".@player." off")
                    sudo("/tptoggle ".@player." on")
                    sudo('/stageselect')
                    die()
                }

                
                sudo('/pex user '.@player.' group set '.@class)
                sudo("/fly ".@player." off")
                sudo("/gamemode survival ".@player)
                sudo("/effect ".@player." clear")
                set_peffect(@player, 14, 1, 9999, true, false)
                sudo("/minecraft:clear" @player)
                sudo("/god ".@player." off")
                sudo("/tptoggle ".@player." on")
                
#                include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
#                _changeSkin(@player,@hero['sig'],@hero['val'],@hero['name'])
                if(@hero['trail'] != ''){
                    sudo("/trailsid ".@hero['trail'])
                }else{
                    sudo("/trailsid none")
                }
                sudo('/stageselect')
        }
    )
)

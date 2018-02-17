register_command(run, 
    array(
        description: 'Set a player on fire',
        permission: 'powers.run',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @plr, @args) {
            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @class = _getheroclass(@plr)
            @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
            @hero = yml_decode(@contents)
            @maxRun = 0
            if(array_index_exists(@hero,'run')){
                @maxRun = @hero['run']
            }else{
                msg(color(RED).'Sorry, you don\'t have /run');
                return(false)
            }

            if (array_size(@args) != 1) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /run <0-'.@maxRun.'>');
                return(false) 
            }
            @requestedRun = @args[0]
            if(!is_numeric(@requestedRun)){
                msg(color(RED).'Please enter a number, not "'.@requestedRun.'"');
                return(false)
            }

            if(@requestedRun > @maxRun){
                msg(color(RED).'Sorry, your max run level is '.@maxRun);
                return(false)
            }

            sudo(/effect player() 1 0)
            switch(@requestedRun){
                case 1:
                    sudo(/effect player() 1 9999 1 true)
                    break()
                case 2:
                    sudo(/effect player() 1 9999 2 true)
                    break()
                case 3:
                    sudo(/effect player() 1 9999 3 true)
                    break()
                case 4:
                    sudo(/effect player() 1 9999 5 true)
                    break()
                case 5:
                    sudo(/effect player() 1 9999 8 true)
                    break()
                case 6:
                    sudo(/effect player() 1 9999 10 true)
                    break()
                case 7:
                    sudo(/effect player() 1 9999 50 true)
                    break()
                case 8:
                    sudo(/effect player() 1 9999 100 true)
                    break()
                case 9:
                    sudo(/effect player() 1 9999 255 true)
                    break()
            } 

        }
    )
)

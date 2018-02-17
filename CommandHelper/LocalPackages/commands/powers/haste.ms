register_command(haste, 
    array(
        description: 'Set a player on fire',
        permission: 'powers.haste',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @plr, @args) {
            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @class = _getheroclass(@plr)
            @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
            @hero = yml_decode(@contents)
            @maxHaste = 0
            if(array_index_exists(@hero,'haste')){
                @maxHaste = @hero['haste']
            }else{
                msg(color(RED).'Sorry, you don\'t have /haste');
                return(false)
            }

            if (array_size(@args) != 1) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /haste <0-'.@maxHaste.'>');
                return(false) 
            }
            @requestedHaste = @args[0]
            if(!is_numeric(@requestedHaste)){
                msg(color(RED).'Please enter a number, not "'.@requestedHaste.'"');
                return(false)
            }

            if(@requestedHaste > @maxHaste){
                msg(color(RED).'Sorry, your max haste level is '.@maxHaste);
                return(false)
            }

            sudo(/effect player() 3 0)
            switch(@requestedHaste){
                case 1:
                    sudo(/effect player() 3 9999 1 true)
                    break()
                case 2:
                    sudo(/effect player() 3 9999 3 true)
                    break()
                case 3:
                    sudo(/effect player() 3 9999 5 true)
                    break()
                case 4:
                    sudo(/effect player() 3 9999 10 true)
                    break()
                case 5:
                    sudo(/effect player() 3 9999 20 true)
                    break()
                case 6:
                    sudo(/effect player() 3 9999 30 true)
                    break()
                case 7:
                    sudo(/effect player() 3 9999 40 true)
                    break()
                case 8:
                    sudo(/effect player() 3 9999 50 true)
                    break()
                case 9:
                    sudo(/effect player() 3 9999 127 true)
                    break()
            } 

        }
    )
)

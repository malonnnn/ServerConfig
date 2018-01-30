register_command(skins, 
    array(
        description: 'Power',
        permission: 'command.skins',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @class = _getheroclass(@sender)

            try{
                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@class.'.ms')
            }catch(Exception @e){
                tmsg(@sender,color(RED).'Sorry, this character doesn\'t have any extra skins :(')
                tmsg(@sender,color(RED).'(but you can add some if you want, anyone can! Just take a hero making class, they are held every weekend, but can be held any time upon request.)')
                die()
            }

            if(array_index_exists(@hero,'altskins')){
                @numExtraSkins = array_size(@hero['altskins'])
                tmsg(@sender,color(RED).'You have '.color(GREEN).@numExtraSkins.color(RED).' extra skins!')
                for(@i = 1, @i <= @numExtraSkins + 1, @i++){
                    tmsg(@sender,color(RED).'/skin '.@i)
                }
            }else{
                tmsg(@sender,color(RED).'Sorry, this character doesn\'t have any extra skins :(')
                tmsg(@sender,color(RED).'(but you can add some if you want, anyone can! Just take a hero making class, they are held every weekend, but can be held any time upon request.)')
            }
        }
    )
)

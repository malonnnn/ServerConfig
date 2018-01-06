register_command(exitgame, 

    array(
        description: 'Unplugs from The Matrix',
        permission: 'command.exitgame',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {        
            
            @plr = player()
            assign(@cooldown, 10)
            
            assign(@lastUsedMindLock, import(@plr."lastUsedMortal"))
            if(@lastUsedMindLock + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedMindLock, @cooldown), divide(time(),1000)))
                tmsg(@plr,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use this again!'))
                die()
            )

            include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
            _mortal(@plr)

            @ploc = ploc(@plr)
            @world = @ploc['world']

            switch(@world){
                case 'survival112':
                case 'survival112_nether':
                case 'survival112_the_end':
                case 'greenfield':
                case 'metropolis':
                case 'gotham':
                case 'infinitycity':
                case 'fortressofsolitude':
                case 'hallofjustice':
                case 'waynemanor':
                case 'titanstower':
                case 'broville':
                case 'starlabs':
                case 'atlantis':
                case 'hogwarts':
                case 'nyc':
                case 'rapunzel':
                    runas(~console,'/warp vrexit '.@plr)
                    broadcast(@plr.color(RED).' has unplugged from The Matrix!')
                default:
                    runas(~console,'/warp '.@world.'exit '.@plr)
                    msg(color(RED).' Welcome back to the arcade!')
            }
        }
    )
)

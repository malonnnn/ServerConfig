proc(_isWorldExplorable,@world){
        switch(@world){
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
            case 'ooo':
            case 'ccjitters':
            case 'legionofdoom':
            case 'starktower':
            case 'helicarrier':
            case 'chicago':
            case 'dbzworld':
            case 'pokemon':
                return(true)
            default:
                return(false)
        }
}

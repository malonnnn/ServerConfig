proc(_checkJobs,@player,


    if(has_permission(@player,'is.headbuilder')){
        msg(color(RED).'That player is already a Head Builder')
        return(false)
    }else if(has_permission(@player,'is.builder')){
        msg(color(RED).'That player is already a Builder')
        return(false)
    }

    if(has_permission(@player,'is.headhelper')){
        msg(color(RED).'That player is already a Head Helper')
        return(false)
    }else if(has_permission(@player,'is.helper')){
        msg(color(RED).'That player is already a Builder')
        return(false)
    }

    if(has_permission(@player,'is.headcoder')){
        msg(color(RED).'That player is already a Head Coder')
        return(false)
    }else if(has_permission(@player,'is.coder')){
        msg(color(RED).'That player is already a Builder')
        return(false)
    }

    if(has_permission(@player,'is.headpolice')){
        msg(color(RED).'That player is already a Head Police')
        return(false)
    } if(has_permission(@player,'is.police')){
        msg(color(RED).'That player is already a Builder')
        return(false)
    }

    if(has_permission(@player,'is.headlawyer')){
        msg(color(RED).'That player is already a Head Lawyer')
        return(false)
    }else if(has_permission(@player,'is.lawyer')){
        msg(color(RED).'That player is already a Builder')
        return(false)
    }

    if(has_permission(@player,'is.headjudge')){
        msg(color(RED).'That player is already a Head Judge')
        return(false)
    }else if(has_permission(@player,'is.judge')){
        msg(color(RED).'That player is already a Builder')
        return(false)
    }

    return(true)
)

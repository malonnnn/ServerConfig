proc(_commandCooldown,@player,@cooldown,@cooldownID,
    assign(@lastUsedCommand, import(@player.@cooldownID))
    if(@lastUsedCommand + @cooldown > time() / 1000,
        assign(@timeleft, subtract(add(@lastUsedCommand, @cooldown), divide(time(),1000)))
        msg(concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use mind control again!'))
        die()
    )
    export(@player.@cooldonID, time() / 1000)
)

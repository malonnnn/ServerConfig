proc(_waifuWinner,@winner,@loser,@waifuName,@waifuSwitch, @waifuEscape){

    @loserUUID = puuid(@loser,true)
    @waifuUUID = puuid(@waifuName,true)
    @winnerUUID = puuid(@winner,true)
    export(@winner.'inActiveChallenge',false)
    export(@loser.'inActiveChallenge',false)

    if(@waifuEscape){
        if(@waifuSwitch){
            broadcast(@winner.color(RED).' has successfully escaped from her husbando '.color(WHITE).@loser.color(RED).'! She cannot be re-claimed by him '.color(WHITE).@loser.color(RED).' again for 24 hours! But to everyone else, she\'s wide open! '.color(WHITE).'/claimwaifu '.@winner)
            store_value('waifus.'.@loserUUID.@winnerUUID.'isMarried',false)
            store_value('waifus.'.@waifuUUID.'spouseUUID','')
            store_value('waifus.'.@waifuUUID.'spouseName','')
            die()
        }
        broadcast(@winner.color(RED).'\'s waifu '.color(WHITE).@loser.color(RED).' got a little rowdy, but he put her in her place! She cannot be try re-escaping for 24 hours!')
        store_value('waifus.'.@winnerUUID.'lastChallengeTime',time())
        die()
    }

    if(@waifuSwitch == false){
        broadcast(@winner.color(RED).' has successfully defended '.color(WHITE).@waifuName.color(RED).' from '.color(WHITE).@loser.color(RED).'! She cannot be attacked by '.color(WHITE).@loser.color(RED).' again for 24 hours!')
        store_value('waifus.'.@loserUUID.@waifuUUID.'lastChallengeTime',time())
        die()
    }

    store_value('waifus.'.@winnerUUID.@waifuUUID.'isMarried',true)
    store_value('waifus.'.@loserUUID.@waifuUUID.'isMarried',false)
    store_value('waifus.'.@waifuUUID.'spouseUUID',@winnerUUID)
    store_value('waifus.'.@waifuUUID.'spouseName',@winner)
    store_value('waifus.'.@loserUUID.@waifuUUID.'lastChallengeTime',time())
    broadcast(@winner.color(RED).' has successfully defeated '.color(WHITE).@loser.color(RED).' and taken '.color(WHITE).@waifuName.color(RED).' as his own waifu! She cannot be taken back by '.color(WHITE).@loser.color(RED).' for 24 hours!')
}

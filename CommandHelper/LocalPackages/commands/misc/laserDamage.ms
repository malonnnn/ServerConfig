register_command(laserdamage, 
    array(
        description: 'Gives Player their Superhero Powers',
        usage: '/laserdamage',
        permission: 'console.command',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@aliases, @sender, @args) {


            @vic = @args[0]
            if(import(@vic.'projectileField') == true){
                die()
            }
            console('attacker: '.@args[2])
            console('vic: '.@vic)
            console('amt: '.@args[1])
            damage_entity(puuid(@vic),@args[1])

        }
    )
)

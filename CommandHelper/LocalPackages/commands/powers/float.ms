register_command(float, 

    array(
        description: 'Float up',
        permission: 'powers.float',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
            if (array_size(@args) != 0) {
                return(false)
            }
            
            runas(~console,'/effect '.player().' minecraft:levitation 9999')
            msg(color(RED).'You feel light as a feather!')
        }
    )
)
register_command(stopfloating, 

    array(
        description: 'Stop Floating',
        permission: 'powers.stopfloating',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
            if (array_size(@args) != 0) {
                return(false)
            }
            
            runas(~console,'/effect '.player().' minecraft:levitation 0')
            msg(color(RED).'You feel heavy as a rock!')
        }
    )
)

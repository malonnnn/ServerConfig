register_command(food, 
    array(
        description: 'Power',
        permission: 'command.food',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 0) {
                msg(color(RED).'Usage: /food')
                return(false)
            }
            @food = array(
                'apple',
                'baked_potato',
                'beetroot',
                'beetroot_soup',
                'bread',
                'cake',
                'carrot',
                'chorus_fruit',
                'cooked_chicken',
                'cooked_fish',
                'golden_carrot',
                'cooked_porkshop',
                'cooked_salmon',
                'cookie',
                'cooked_rabbit',
                'cooked_mutton',
                'melon',
                'potato',
                'pumpkin_pie',
                'cooked_beef'
            )
            for(@i = 0, @i < 5, @i++){
                @index = rand(0,20)
                runas(~console,'/give '.@sender.' '.@food[@index].' 1')
            } 
        }
    )
)

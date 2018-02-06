register_command(mechbomb, 
    array(
        description: 'Power',
        permission: 'powers.mechbomb',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@aliases, @sender, @args) {

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('dvaMechBomb',60,@sender)

            @ploc = ploc(@sender)
            @ploc['y'] = @ploc['y'] + 1
            @uuid = spawn_mob('VILLAGER',1,@ploc)
            @uuid = @uuid[0]
            @sig = 'UOpdDOSr5NSDi85arTrkVgJbVf7u9tqSOD3c+reESP2Cq9xfpG3k4H1fJxfLt0yw5z5+t29msilaqDISyrGI4XQ/RJcmyvMgjbiNZO0UTbrJGOjDhMmJjrR2tvQKvG/9LdoOqWyuFaxmE02qV9SMtGxYTYS93yfFG8MKz9pPY3T4wWggcZh628jnich78JYZqMFZlLvPSQs7FmKitJDEwlNkdEtLNX1joBj2hvLgSQtdlT/AE7U0G9ktxIW58zDG3oiDLkVCWwGP+Hsm/8uK9l5Ik4+BAXDAahqwlTzYkQNHezB+2WpHVzp/HZ+LSmqtjUO/zXp4uKmW2y1FH+hiKQ+Q2jAY1w1jUmq7vpw8yl/c8X8/nKyYDx0OIg7YnBqO6uATocE2MS1p4hFlO0LcKMwQOWY5A8LqpvCJXfk2lXKUWy+/TbWv5yS9sRBSjWjtGcLdF7ICp04451fJWHP2BRtRtWWWNrrrCTPM3cYl1OhjBqZ7/GQ8K3gpObcOu2CMZuF0BNgxGO35/jvI4NCzF3WhGhYZMY0mP7T9WkO+qnT+6WcfdEy0+O/dILCgO38jyBIeMG2clG3IW+v3AT6Lq8YU9mqn6BMwrfMOv83lkVRed8Km6Ns13I3tDfZ1uBnzYWDwTE58itMULJD1a1QA0feVDk9ddkx6fYkbsG7ifps='
            @val = 'eyJ0aW1lc3RhbXAiOjE1MTc4NjQzNDUwMDQsInByb2ZpbGVJZCI6ImE4ZTE1OWVhZGVlYjRmNzNhMjQ2NTkxYjU4OWFkY2Y0IiwicHJvZmlsZU5hbWUiOiJ4RmxxbWVZVCIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvODk1Yjg5YjhhYWVmMmYyMWU1YTVlOWY4NTA4MjJlZDgxNzM1YWMyMmM3ZDkyZDg1MWUzMmU5M2U0MjI4NzAzZSJ9fX0='

            set_timeout(500,closure(
                set_mob_effect(@uuid, 21, 100, 9999, true, false)
                set_mob_effect(@uuid, 1, -254, 9999, true, false)
                @rest = 'setskin {"id":"87fb3c6c5ff64bf6b326992c6137ea12","name":"tektronic","properties":[{"signature":"'.@sig.'","name":"textures","value":"'.@val.'"}]}' 
                runas(~console,'/disguiseplayer '.@uuid.' player Mech '.@rest)
            ))

            set_timeout(5000,closure(
                entity_remove(@uuid)
                explosion(@ploc,10,true)
            ))
        }
    )
)

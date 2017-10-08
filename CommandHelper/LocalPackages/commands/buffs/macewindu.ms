@plr = player()


@hero = associative_array(
            'name': '§5M§0a§5c§7e §7W§5i§0n§7d§5u',
            'class': 'macewindu',
            'sig': '',
            'val': '',
            'trail': '',
            'op': 'false',
            'speech': "May the force be with you.",
            'powers': array(
                "/buff",
                "/jump 0-7",
                "/run 0-4",
                "/haste 0-1"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 5 true",
                "/effect ". @plr ." 21 9999 19 true",
                "/give ". @plr ." minecraft:iron_sword 1 20:2 16:100 name:&5M&0a&5c&7e_&7W&5i&0n&7d&5u&7's_&5Lightsaber"               
            )
        )

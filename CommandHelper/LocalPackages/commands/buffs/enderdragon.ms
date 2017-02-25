@plr = player()


@hero = associative_array(
            'name': '§0End§de§0dragon',
            'class': 'enderdragon',
            'sig': 'enderdragon',
            'val': '',
            'trail': '',
            'op': 'false',
            'speech': "Roar im a dinosaur",
            'powers': array(
                "/buff",
                "/carryplayer",
                "/dismountplayer",
                "/fly",
                "/flyspeed <number>",
                "Protected by Nekron, mobs will fear you and wont attack you"            
             ),
            'buffs': array(
                "/effect ". @plr ." 10 9999 1 true"
                "/effect ". @plr ." 21 9999 2 true"            
             )
)

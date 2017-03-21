@plr = player()


@hero = associative_array(
            'name': '§eParallax §6Entity',
            'class': 'parallaxentity',
            'sig': 'magmacube',
            'val': '',
            'trail': '',
            'op': 'false',
            'speech': "I'm a mind reader!",
            'powers': array(
                "/buff",
                "/flyspeed <number>",
                "/fly",
                "/jump 0-3",
                "/run 0-3",
                "/haste 0-2",
                "/confuse <player>",
                "/disguise",
                "/msg",
                "/mindlock <playername>",
                "/mindcontrol <playername>",
                "/stopmindcontrol"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 1 true",
                "/effect ". @plr ." 21 9999 9 true"                
            )
        )

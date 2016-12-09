@plr = player()


@hero = associative_array(
            'name': '§2S§awa§2m§ap §2Th§ai§2n§2g',
            'class': 'swampthing',
            'sig':
            'val':
            'op': 'false',
            'speech': "I... AM... THE SWAMP!!!",
            'powers': array(
                "/buff",
                "/run 0-4",
                "/haste 0-2",
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 10 true",
                "/effect ". @plr ." 10 9999 4 true",
                "/effect ". @plr ." 11 9999 1 true",
                "/effect ". @plr ." 12 9999 1 true",
                "/effect ". @plr ." 13 9999 1 true",
                "/effect ". @plr ." 21 9999 19 true",               
            )
        )

@plr = player()



@hero = associative_array(
            'name': '§4Sp§fi§4d§0e§4rm§0a§4n§8(2099§8)',
            'class': 'spiderman2099',
            'sig': '',
            'val': '',
            'trail': '',
            'op': 'false',
            'speech': "Just a kid from Brooklyn!",
            'powers': array(
                "/buff",
                "/carryplayer",
                "/dismountplayer",
                "/jump 0-7",
                "/run 0-4",
                "/haste 0-3",
                "/web",
                "/websling",
                "/invis",
                "/fly",
                "/vis"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 5 true",
                "/effect ". @plr ." 10 9999 1 true",
                "/effect ". @plr ." 11 9999 1 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/effect ". @plr ." 16 9999 1 true",
                "/give ". @plr ." minecraft:web 64",
                "/shot give ". @plr ." webshot"
            )
        )

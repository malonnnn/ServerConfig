@plr = player()


@hero = associative_array(
            'name': '§6B§0u§6m§0b§6l§0e§6b§0e§6e§0(YJ)',
            'class': 'bumblebeeyoungjustice',
            'sig': '',
            'val': '',
            'trail': '',
            'op': 'false',
            'speech': "I can shrink to the size of a bumblebee!",
            'powers': array(
                "/buff",
                "/shrink",
                "/normalsize",
                "/flyspeed <number>",
                "/fly",
                "/carryplayer",
                "/dismountplayer",
                "/jump 0-6",
                "/run 0-3",
                "/haste 0-2",
                "/undisguise"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 10 true",
                "/effect ". @plr ." 10 9999 1 true",
                "/effect ". @plr ." 21 9999 4 true",
                "/shot give ". @plr ." plasmablast"
            )
        )

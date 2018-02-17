@plr = player()


@hero = associative_array(
            'name': '§eV§fe§1ge§fta§8(§eSS§8)',
            'class': 'vegetasupersaiyan',
            'sig': '',
            'val': '',
            'trail': '',
            'op': 'false',
            'speech': "",
            'powers': array(
                "/buff",
                "/jump 0-5",
                "/run 0-5",
                "/haste 0-5",
                "/flyspeed <number>",
                "/fly",
                "/carryplayer <player>",
                "/dismountplayer",
                "/herotransform"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 14 true",
                "/effect ". @plr ." 11 9999 2 true",
                "/effect ". @plr ." 12 9999 1 true",
                "/effect ". @plr ." 13 9999 1 true",
                "/effect ". @plr ." 21 9999 4 true",
                "/shot give ". @plr ." kiblast"
                "/shot give ". @plr ." finalflash",
            ),
            'alts': array(
                'vegeta',
                'vegetassb'
            )
        )

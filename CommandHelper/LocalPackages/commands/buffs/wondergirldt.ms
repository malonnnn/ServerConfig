@plr = player()


@hero = associative_array(
            'name': '§0wo§nder§8gi§7rl§8(d§7t§8)',
            'class': 'wondergirldt',
            'sig': '',
            'val': '',
            'trail': '',
            'op': 'false',
            'speech': "Rhea, give me strength. More than never before, I need it now!",
            'powers': array(
                "/buff",
                "/carryplayer",
                "/dismountplayer",
                "/jump 0-5",
                "/run 0-6",
                "/haste 0-6",
                "/flyspeed <number>",
                "/fly"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 8 true",
                "/effect ". @plr ." 10 9999 2 true",
                "/effect ". @plr ." 11 9999 2 true",
                "/effect ". @plr ." 21 9999 14 true",
                "/give ". @plr ." 420 1 16:10 name:&0Wo&7nder&8Gi&7rl&8(D&7T&8)'s_&eLasso"                
            )
        )

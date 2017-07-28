@plr = player()


@hero = associative_array(
            'name': '§A.§M.A.Z.O.',
            'class': 'amazo',
            'sig': '',
            'val': '',
            'trail': '',
            'op': 'true',
            'speech': "I have no more to learn from you.",
            'powers': array(
                "/buff",
                "/levitate",
                "/mindcontrol <playername>",
                "/stopmindcontrol",
                "/apokolips (travels to your homeworld of Apokolips)",
                "/tp",
                "/carryplayer",
                "/dismountplayer",
                "/empower <playername> (gives player strength 10)",
                "/speak <playername>",
                "/grow",
                "/shrink",
                "/jump 0-9",
                "/run 0-9",
                "/confuse <player>",
                "/haste 0-9"
                "/buff",
                "/kill",
                "/gmc",
                "/gms",
                "/tp",
                "/fly",
                "/skull <player>"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 15 true",
                "/effect ". @plr ." 10 9999 4 true",
                "/effect ". @plr ." 11 9999 4 true"
            )
        ) 

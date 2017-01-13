@plr = player()
 
 @hero = associative_array(
             'name': '§5Psy§5locke',
             'class': 'psylocke',
             'sig': 'tfk475DQhs7bHo28h4ZhqX3czQsRtIkfLykj0CMkNNNeOYjhVqSuZd6XF714R9xoj03UW9Qjb1/+41NusjU2XR6Bq3sN3kiKArPF19z7dGbwpacy/Yu6gVUFAKAQXTkeTdgD15mCP2iyONEtGqA7tvn1k/Z6y378nqNvlcuZW9X/Iql7zdNnDSHCEFQ/W+D2xfy8h/tcvv62Ni5x9qaCZMs9VTOXi1giqBfxHJuwphmWPoVeP+ckoMgO4ejB0d3Agr/vWcVE5GFnoWyInr4PXEu5YEWlvV6cKWPrLIpX5ZKtUWZzvfzGhu/1LB5h1qa/L6GSXYM1AJo16xCee8JGeaPvM6XtWaNQQq3bY7Y4cAtL+o1XPlBFMPdDpRI+zYRwAMASCbiNRxjsax2hX1O0wxf3f3ooS30Pcln5dNRrNYy89BRNOdXm7jJhfRSe02di/6nU9t9vwhkhCUzZh3HFSXKD2EBvFfqVVMN3RxKDY2G0eHhqe4HXkxV28xDVJG0pdd7JF1gXY9VzX/mVIIRbwVOX8nrYNZDScRXr4iLxHO0gqRbm92i5bPb8fzmSwrHwJs0xNz7LI36HzO1qrVVeGdgQCeJp0dkZnBEgUyGqgkfWR0zQWz+KTHgmQmZ4+jlsqqvmFJK3bXuFxWenU8AoN4N65brZGCetdn7byn/CQDs=',
             'val': 'eyJ0aW1lc3RhbXAiOjE0ODQzNDg5MTAyMzEsInByb2ZpbGVJZCI6IjBlNDJlNDc0MTM0ODRmYTg5N2M2Y2IzOWE5YzA5ODhmIiwicHJvZmlsZU5hbWUiOiJjYXJkaGFkeSIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7Im1ldGFkYXRhIjp7Im1vZGVsIjoic2xpbSJ9LCJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzdlODAzNjE5MTgyM2ExYzQ4MDZjZTRjZmEwNWJlN2U4OGQ4ODYyMzUyMzM3YzVjMDM1MGNkZDRkODgxM2NjNiJ9fX0=',
             'trail': '',
             'op': 'false',
             'speech': "I can see, into your mind",
             'powers': array(
                "/buff",
                "/carryplayer",
                "/dismountplayer",
                "/jump 0-5",
                "/run 0-3",
                "/haste 0-2",
                 "/speak <player> <message>",
                 "/mindcontrol <playername>",
                 "/stopmindcontrol",
                 "/confuse <player>",
                  "/flyspeed <number>",
                  "/fly" 
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 5 true",
                "/effect ". @plr ." 10 9999 1 true",
                "/effect ". @plr ." 21 9999 4 true",
                "/effect ". @plr ." 16 9999 1 true",
                "/give ". @plr ." minecraft:gold_sword 1 20:30 16:20"
            )
        )

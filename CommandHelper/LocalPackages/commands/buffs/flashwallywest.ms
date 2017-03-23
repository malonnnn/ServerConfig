@plr = player()

    

    
@hero = associative_array(
            'name': '§4Fl§ea§4sh§8(WallyW§8)',
            'class': 'flashwallywest',
            'sig': 'VAdJJWGxmnXCqfLMszZa8l5fSKwhAjb5MUoBdCS7cgMKPaPYQjk7M0liP44o7XbZD0bKITW3zxuzywjDdhhKI3RNmcoKdDjsv20EnJaYQI3eWm51UJNuVns6SAIDxDNW4pSYnnr8rOABRw7whgcEHZMAFp7WGMhp5tdF8dRk9N7Kc4UsFixUzFfezGBs+ia+dJ2UoH3cfqaZxD/u7sJHZIYDT8Ksuz0v+r/4MhsdEutH6AOJuxcQhn9QF3TmXGZ+56BNZCqLfuNGJu0xjhjcuphZj+j68S6tmKQ52oWBS6g5pe3i3D0E9Rd6LmNBmQio8EVJ7SU1v5It0emOn7Mlbe/4JkuJYI5TQAacetSBnJbTnVr+N7dJrwDle9GhgquZ58w/f6/j4x6daMlIZR6MvhkuN8AAdUylIdeAOHy+u10H7BTqGSe2i0/gdtg6T0Hgl7DOJFTiSthhfavB84I0/b85b48YMWmXcR9jO3/Um++L/9vOOnPq4vLCdOQilLlzSIqhjmq5fHWlFJi8lVWBTkQV7ilHE9mwNTQeq6wXAwpCaGIvl2qIdz9h968mLot8yxvFEWseolFs1sEb/tkz/8KkRBkCEJtL9k86RAcEnS6xENDx21LiUW4+wV0SuugGOTXguamQ5Ne67eeWfVJ81/N3Kb+z8AkiLF8JGfydwLQ=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0Njk5OTQwMjM4MzQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2YzYjk4MTZiZGU1MmRkYjNmOWQ5NzgxYTMyYzg3MzNmZDMzMmQ0YTZhN2FlYjU4YjA3ODE2MjNkNzY0NWVkZiJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "I am Wally West, unleash the speedforce inside of me!",
            'powers': array(
                "/buff",
                "/run 0-9",
                "/run 0-1 (In the speedforce)",
                "/jump 0-3",
                "/back (In the speedforce)",
                "Access to all warps in the speedforce",
                "/speedforceteleport <playername>",
                "/speedforcebuffs",
                "/speedforceheal <playername>",
                "/whirlwind",
                "/carryplayer",
                "/dismountplayer",
                "/haste 0-7",
                "/tppos <x y z world>",
                "/thru (phases through walls)",
                "/thrudestabilize",
                "/modifyspeed <playername> <number>"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 10 true",
                "/effect ". @plr ." 10 9999 1 true",
                "/effect ". @plr ." 21 9999 4 true",
                "/give " . @plr . " 95:4 5",
                #"/give ". @plr ." minecraft:leather_boots 1 0 {AttributeModifiers:[{Operation:0,UUIDLeast:1,UUIDMost:1,Amount:123456789123456894321654.0,AttributeName:generic.movementSpeed,Name:speed}],display:{Name:Boots of Wally West}}",
                "/give ". @plr ." minecraft:iron_boots 1 8:30 4:30 name:&4S&ep&4e&ce&ed&8s&0t&9e&1r_&4Boots"                
            )
        )

@plr = player() 
 
 
 
 
 @hero = associative_array( 
             'name': '§4M§ce§4p§ch§4i§cs§4t§co', 
             'class': 'mephisto', 
             'sig': 'Mw9RmKZEJh/9/vgZE9rATkRwsL7GhJHH9ZaZ5JAA8fwk4lwbABKOucI1koE+Aa+PFLunlFpu9PQ+djzdI+p9HV8vQGMZT2y7PPtPkhLssUpeubzOKZaFiu3Ka8uf3KPEdJkkfzhHbF0Q2poQLvpcEUrusecyNskHMlqb1Tg0b0eIIP77vcHk8Sbz8wpRPt2Bf6GKQEwR1qYBPIFj1ynU7EVKb8lH3DslsMiltZUkyNDqFOwF1+VLHwueMxkrNS5m/BSCu+qvaubYem+Bw2FwUxkmuS2y4zvs4/mk51u00WAhM62vVfMyQIBmDVozhI1NaOMW5XlhPxXNY6f6SxZCccPMv9MWxKQTCHSX7UAOYoiAKHAoIfPiRNVhGcOYFODb9v0iS6psu2r2YrpHFYqKLMfCcfXkZqzY9oT5YDOSJRzrjjnVF5lHhsWAs4LrsK+Q7404nYHZgJ0rsdItE0mEOtwdlTsVCNxV7qvRcdNzdgAUKsqdXgcC5WvGaL1Ut1/sgRTnREiND0DVhCMZmhXPFlN9n9K1M1HLUUl4hGcWW25d07TnFG6U7N0nOSvNCdXFxOA6MWwaCWsXKrnxXjkLaLnLn614flGRjUa02edmqe2K9WXpvB6KmU0vroB3zfdFUShaJZR0CAUytwi93/1XEHH8zURtEC1+BkhBr95V3rE=', 
             'val': 'eyJ0aW1lc3RhbXAiOjE0OTEwNjU5Mzc0NTAsInByb2ZpbGVJZCI6ImY2MjE1ODZlOGVmODQ0OGQ5MjY0ODZiNjEzNzUwNTJlIiwicHJvZmlsZU5hbWUiOiJteXRoZ3V5MTIyNiIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOTdiMGVhM2JmNDYzNWZkNWQyMThkYWZlMjdiZGYzNGRlZmZjZTk5MGFiNjNjYzYwMmU4OGIzNzcxOWRjZjc4YiJ9fX0=', 
             'trail': '', 
             'op': 'false', 
             'speech': "Now I will take your Astral Energy!", 
             'powers': array( 
                 "/buff", 
                 "/confuse",
                 "/unconfuse",
                 "/tppos <x> <y> <z>",  
                 "/forcechoke <playername>" 
             ), 
             'buffs': array( 
                 "/effect ". @plr ." 11 9999 2 true", 
                 "/effect ". @plr ." 21 9999 9 true", 
                 "/give ". @plr ." minecraft:iron_sword 1 20:1 16:5 name:&4Mephisto's_&cSword", 
                 "/shot give ". @plr ." astralblast"                 
             ) 
         ) 

@plr = player()



@hero = associative_array(
            'name': '§eN§6aruto',
            'class': 'naruto',
            'sig': 'cUpD62PKJYkqxydv1dBoOcihpQwajSr28cx+0xmgZdatYFhvIg2G3k4ybxC14rZiVbTthogDSOb30/i83PWoN67hte63VBXRx+rjbXf4Q8O1EuX2h2eD7EvX1au94+iSF6t6/nkl4MnoVEcQYoAjQcWpL9rfnm8Yde0kUwnKJhEDXDeDbJG1i/Nk+/za/7ZfrMpd5oLqCRX4SNRdTj5d9WoyvBwi8diwDb52ETAOxIm/UbAhY2YUeGkfQQtbFArglX4+/BmAqreyjXF//cA3w/pE1x1XoUZozm5nEJ83zaKF/yExD4OkX6iLGBodY+dFejwIQxXzP6N9wIobOzwZsgiZOkCm9jDp+HhfV76HabakWkQDAc7S6HGrV/8VN1JB4wGu+UoB8ruwfbv60IVGWFEQbD5EQDfp6RPHdWsX08Ra56ip3Lbp1os5vOjfJuUCqXv5YPKJyPHinjSLQancJPcMCj/OnOJ1gSjW9AIYGAeiI5PSM0wyDwMoIBb4B9xxkhC8p9dOA66+Jr7SsBJkj1OzFZUDNCOTZvSQl5NWOzQKSUbop3y9uk+eAdJcpwzGsW+ymSXmp0U7XHLbdlU+RRSxMKOJQNbnjlqUD6qb8aR7Zwu2vi5CXOupnHj3wJ2CzUWne/XD3CRtOlLpbmHPSDyleu/BxwmkPpFPlIqha/k=',
            'val': 'eyJ0aW1lc3RhbXAiOjE1MDQzODgwODExMTgsInByb2ZpbGVJZCI6IjdkZmY5MWRkOTZlNjRiNzM5ZGZhMTc5OTJlMDU1Njk0IiwicHJvZmlsZU5hbWUiOiJUaGU4dGhIb2thZ2VUcmV5Iiwic2lnbmF0dXJlUmVxdWlyZWQiOnRydWUsInRleHR1cmVzIjp7IlNLSU4iOnsidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS85ZDQyNWRkZDk5NTU4NDJmZDg5OWY1MzQ5MjMzZDc5Y2YzNTViMzVmZTU1YTFjZWY1YTIyYzQ0ZDg5YTA4MCJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "I will become Hokage one day!",
            'altspeech': "Punch your opponent in the next 10 seconds for massive damage!",
            'powers': array(
                "/buff",
                "/carryplayer",
                "/dismountplayer",
                "/rasengan (very powerful punches for 10 seconds)",
                "/jump 0-7",
                "/run 0-4",
                "/haste 0-3"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 5 true",
                "/effect ". @plr ." 10 9999 1 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/shot give ". @plr ." throwingstar"                
            ),
            'altbuffs': array(
                "/effect ". @plr ." 5 10 20 true"
            )
        )

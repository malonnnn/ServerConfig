@plr = player()



@hero = associative_array(
            'name': '§fA§7n§0t§7i-§fV§7e§0n§7o§fm',
            'class': 'antivenom',
            'sig': 'NZClSsjFHNCNy56+EB5st3KOiauH7Zzqa7pkA5uwKjTcDum+TIOAnuQTyGwqSpUZhWTKIsAFEFdMyXFJxT7xP7qZUTv764HYJNLo0uJCjQdKIsPjNf8C1kDsJ/l+VePAjvPiXVCWWB/vuOGZZlbRvCWDdqVJMthsVu5OUWwYLqxmr0LIilZwM0Aqvapdm66cWMKxOkuK+40Dvsj48m99tXDRxnFfcrPO9n0htyPbZOrfxfT6rgc5nRrZKNFoLA+/YyaDZ2HPIe42/yKjmV1Jzn43+WVLLxrpc4GusOTkwgZyRa/u2aJo4YaGoTJrpLsZ8CY7uQqOKyI6mqqWeR2tJpkq8+Z/KfEe4LFdTRCNEWH+rQsB94GY849vp9aT88dwU7dEWZdrSTPit9Xta7GjAVcUy2ZqCGe2IKOqSYZRR/Fydiyo0Fd1EvhkAD4sjt4ClRTKNPyK3O9RRRYf2clK94US0KqvO2sq56S5t/yzKNMGRnD9Id62xYYgRknGyG+YxIVTT/BkJ3QonhSuqaxvEOvlmb7AGKv6xBsb3wIGd+XzoCCKjcTcC1efb/BUO6yHXud+yrCoCSeXkICDC6NYIemh2bJdDPu6tncR15PPqRvGqrkGrm17gSx5lgOwCVQjfMHiksGfq3R/+ZIu3jUUVaDOhpIj1yZbbpoC2dFodZo=',
            'val': 'eyJ0aW1lc3RhbXAiOjE1MTU4ODYxMzE5MDUsInByb2ZpbGVJZCI6ImYzMDc3ZTY3OWNmODRiNDhiNDg4NGE1ZmQ4OTlkNjk3IiwicHJvZmlsZU5hbWUiOiJLYXJtYTAwMDEiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzZjYWNjZDcwZjQ3MjdkODk4OWUxY2Y3NDg4ZDg0NWQxYTgyNjI1Njg1NjkyZmNhZDEyZWQ4NjJkZmU1MzEyYiJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "Ill lay my hands upon you and CURE YOU ALL",
            'powers': array(
                "/buff",
                "/carryplayer",
                "/dismountplayer",
                "/jump 0-7",
                "/run 0-5",
                "/haste 0-4",
                "Wall climb by standing next to a wall and pressing crouch and vines will appear. The vines are only visible to you, not to other people, so it looks like you're really climbing the wall! You can stop climbing but continue to press crouch to stick to the wall in place and look around.",
                "With an empty hand, right click the air and you will sling web out from your hand. You can use it to swing around the city! Note: technically, you're sitting on an invisible chicken (lol), so if you wonder why you can't move it's because you have to press crouch button to get off the chicken first xD"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 6 true",
                "/effect ". @plr ." 10 9999 2 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/effect ". @plr ." 12 9999 1 true",
                "/give ". @plr ." minecraft:web 64",
                "/shot give". @plr." webshot"
            )
        )

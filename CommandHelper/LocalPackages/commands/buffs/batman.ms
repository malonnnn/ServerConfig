@plr = player()


@hero = associative_array(
            'name': '§7B§ea§0t§7m§8a§7n',
            'class': 'batman',
            'sig': 'SR15FEYOESBW570M+IKHpRjykgMd3ATxyh4S55Up0OUobbFPyhlZqh0i6lPm11Gba9v0+B8JT/dPeNxDQuaKgLJoA8jEFVeSdmN4hnd4X//1To1LrQV6LNehxQKHk0cs3l9DSsWR20iBgwN+oKD6Ylie8PnDF7nzXVbNsE1ZcV16DyEyiFp75vXl/CYYVsLWaU6WQP3ghCzupGfMPHFgg5xBzmpO1JTARrh5+awjcpMv3jXc9XSRYTEgDKpMgyqQVrNBlAtZa0r+s7s6HBgYPz3we9S54J3JtpG+gsbt0axwFgCOXoF0fsojLI3VIBVDJKD0ORpZw9t4zG3PaU30P5o7wwirEAwRqVhQDmamBtCYqYARuuvOfQtz/zSIrhaUuqpau/IFu05pro/IKBQzh6Yc99ARjOoscQQR8e200f9NWRCnaMaLEAfE5u944BOILjW4A5SPijQLd5VRZCp2HzN7CLeM2P1RLcNQF3eb3G+7PZN0wiPwlATU36KDhbwjHj+r3/y2FU4KJLvC7ulNBXdfO3f2C7cj387fQwm1l/HgVwUvRLVr70YxNefwXFWh5xekCMv/M82Qjr97vbQ9LY5HCKCAb/HgDz8gU7mxOiCrYE1Oc6yfvA2Oq8+Vw6E7EuDZLfv+v0Us383sS6LYU3lvwtFOkrcsDtlUfHY4ypI=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NjQ3NDgyNTE1NDMsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzc3NjZkZmM1Mjk4ODRlODk3MzRkNDI0ODRmNDFjZmZlOGU4ZGQ2NDMxMzc1NTQ0MjQxNTg2ODdkY2VhNGFiOCJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "Your mind becomes razor sharp!",
            'powers': array(
                "/buff",
                "/jump 0-3",
                "/run 0-2",
                "/haste 0-2"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 5 true",
                "/effect ". @plr ." 21 9999 4 true",
                "/give ". @plr ." minecraft:elytra 1 70:1 34:3 name:&7B&ea&0t&7m&8a&7n's_&8Glide_Wings",
                "/give ". @plr ." minecraft:ender_pearl 5 name:&7B&ea&0t&7m&8a&7n's_&8Grappling_Hook"                
            )
        )
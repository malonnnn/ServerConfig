@plr = player()


@hero = associative_array(
            'name': '§4D§0a§4r§0t§4h M§0au§4l',
            'class': 'darthmaul',
            'sig': 'tDSS8my4IXRrpDW/SEeegWvU9F8kZIvg0gmg9mY2DBBt/1ViZcxnbv61CjztxHiErM0brUp3ZoJGEi9Wgm3kfQFYLILskrgQBdoKo+6dV17vob+5d+jPVAsRJyn/fNdxn04KK/2C5sNgK217DIo4mCe9j6c4q2MwCL9nfrrjxPiZxY3yLrGDMdR9JZSHq6SocASzycsfS9DwuGieX9HdH0Olxm5NZeqXmw4I4EQb6BQcLJte0PIma5uMeKef2etCzxhlXEGKLlIw1YbRJn6fYp9BWhDRI1scRC5tk3uU77at+NNL7y7guysrDZDjszd1yEtuqo7lEJ4H6vbooKvUVJcrRpm2SEsIU2ENnZ1k9pahIpeFcnHjrL1ONhjqjDex0VV5pNXct+qYa5Yp0xP87USEGEoID1qpjvrgluoq2Ntsk+1aZtHGMZkpBXPpuKmRgXQs4z8Cv/ud7YRMoDRjDqqW+eZ1neW1wk2EQ7v/qxwbtFSmhW/Hd1+JQB+VVOSaJZANiJJPge354FFFOdit3DmAQYDp762IVoZ3qwEocOcRanPPkSCUuXpn07otBw/VhUo2OPuJaBzm4LFCQIgXNAQbBSD+I2t5ex+gQBRZgct2/gJx+IqDOKGGafWon7Zl7prh/JEiPauPW6BUliRcQJ4Mjdxf93GYs3N6Gk0g4XQ=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NjQ3NjI1MDk0MTQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2UzZWYxMWQ3ZDU0OGIxNGRkOTZhYWNlMzM0NGQ5YjIwZWUyYmY2ZTAyODFjMTE1NDdlY2ExZjQ5YmJlNmM0N2YifX19',
            'trail': '',
            'op': 'false',
            'speech': "Fear is my ally.",
            'powers': array(
                "/buff",
                "/jump 0-7",
                "/run 0-4",
                "/haste 0-1",
                "/forcepush <playername>",
                "/forcechoke <playername>",
                "When you punch a player empty handed, your victim is struck by lightning (force lightning)"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 15 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/give ". @plr ." minecraft:iron_sword 1 20:2 16:100 name:&4D&0a&4r&0t&4h_M&0au&4l's_Lightsaber",
                "/shot give ". @plr ." forcelightning"                
            )
        )
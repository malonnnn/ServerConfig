@plr = player()


@hero = associative_array(
            'name': '§0Black Panther',
            'class': 'blackpanther',
            'sig': 'soTo4/s4tYPOPDdaxXMF7vaeEb0fEivWA+no1jrYzCN7bKp/3CX4Sr40dln9Q6Zc7uiZ/kY/mGdszfQQdCTCvuJL0Qi1uX6xGBdhKtAZbqS8qyR+wx2WVramj3md6/wQKCpDt1eh6QsogRfirTkWMjI+16bJzCij6P4Ml9oLylhU8XqmLO1aLRQDL1KpnmGu7st+0Fwwo2xeCbwgxv9NQRXQPjlCvv8lODSnuAeZIuVVPwrxCCb5R4KHXZa/jm6n8nLXnwQGVflUVwZbzGXsbbAVfUjmSxnSF8RAqQd5ilYcIJU1kvbhlirxXMqMgm6YBX54rK3AWWkho9j09I0y/8dU/XAsLBAnTyhfVz6D+cRk1NfSKEJBN2szdDY7B2+e1GUHt9jnyfrENFYYII18nuwulJ2Yqv9hUTxi0OGSX86UCWOQD6lGS6hz5Qp8Cz0hK4eD5wJBOabe7j5YByTSqTkHdCZyxVA3eu98DrlOgZfSWjP6Rr5BMLOXaEVyH0wY3KEAg8qP79ur6o74ZGGLqYLutsQRRJl1NSv1p/JJ1dX+aY/QC632eOEjx4/YjUxKVR1CK0/2eCj2MQBTGRdNMpu6CwI0N9RVSZoBe3HL+pIwe426loQgwYDh6YoSVbhtqZuG7kzECQURFN2jbUMSCD5/EC9/Hfi5vWoEpdha2ow=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NjQ3NjMxMTkyMzQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzdiODY0ZTdmY2Q4ZDJhOGExNWZjODVmZTNkZDYxZGFlODg4NzRlNjBkOTU5NGQ5OTZlODY3ZmYxNmIyNGMifX19',
            'trail': '',
            'op': 'false',
            'speech': "I am...The Black Panther!",
            'powers': array(
                "/buff",
                "/jump 0-3",
                "/run 0-3",
                "/haste 0-3"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 15 true",
                "/effect ". @plr ." 10 9999 1 true",
                "/effect ". @plr ." 11 9999 2 true",
                "/effect ". @plr ." 21 9999 4 true",
                "/give ". @plr ." minecraft:iron_bars 1 16:10 name:&0Black_Panther's_Claws"                
            )
        )
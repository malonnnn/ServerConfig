@plr = player()

    

    
@hero = associative_array(
            'name': '§1S§cp§ee§ee§1d §cD§ee§1m§co§em',
            'class': 'SpeedDemon',
            'sig': 'TGlUqUxx/n07H6HdGJOWxOfAZO2U2CNotxT2qAX2WLnvAKxA9vZ/5qhp1HLjXUisditj9dUPDArIXnX+BEd1zZArzoWPvlRd+zia1YQMClESVEOQ1HSNR6jMb5042x4vzMMQiDiL3A5F9NM4xPXFK/AO5Ehwiz4YfKVwffxEgh02Hq1YvCOy8b4a8ceD898vtKc8rnTFRKJTC/CcXm9BD1NRQSUxpvgQv/mXhVtWcyMf5ST8mwbr5K4Qn1IpY3UwkBBHbDlL9qWH2VG8a4/Rop6DUyKQzOrfVSGYnz1H6Zh4+gyIkx1zqF0kDVuyztbqeccAVZNJiJ6twncGHwjUCyufFYsIuDVpkyA8r8P+ZEpzZRSx1B4jEo8jwGT92pGDspwZZo3Frm1YshyHcPJowyKNy7r/1ayl8zp5yeiCnIgP6OJAGjNqUDq+OG+06IITCHW7KHxxaW0R0uShOpiLsNOtd+IIDzn9G2ouaNe5XRv5FjKUxpxUG5Ft5a0XU4+OqLRZ7MgRLPKCBAvKpUs7dGCBUsOZek3tlyGGU59yjhtnKK7rnjpwqgI8CNDeoSfH6gdU/H3btj7XnXq+IuoHFYFI8g5CeDo/ZjTU5bDniPdA1YmKXJP4/Qvbk9GTJXqDlyR/DTfN1/Dx46d96eFh5S30AaStKF5u/egnPpLZpGY=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0OTIyNzM0ODg2ODcsInByb2ZpbGVJZCI6ImIwOWI2NjE4ZTAzNTRlMWZiZTRlZjAxZWM2ODg4MDAxIiwicHJvZmlsZU5hbWUiOiJCY3J1bGV6Iiwic2lnbmF0dXJlUmVxdWlyZWQiOnRydWUsInRleHR1cmVzIjp7IlNLSU4iOnsidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS8yZGZmY2E0NTQwNWNhZDE0NjNjYzQ3NTI0YTdmZDc4OGRjMWEzZjRkNDIzYmE5YmFjZTJmOTBkYzBkNTEyIn19fQ=="}]}',
            'trail': '',
            'op': 'false',
            'speech': "Let's run like the devil and make Hell freeze over!",
            'powers': array(
                "/buff",
                "/run 0-7",               
                "/jump 0-3",
                "/carryplayer",
                "/dismountplayer",
                "/haste 0-6",
                "/modifyspeed <playername> <number>"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 10 true",
                "/effect ". @plr ." 10 9999 1 true",
                "/effect ". @plr ." 21 9999 4 true",
                #"/give ". @plr ." minecraft:leather_boots 1 0 {AttributeModifiers:[{Operation:0,UUIDLeast:1,UUIDMost:1,Amount:123456789123456894321654.0,AttributeName:generic.movementSpeed,Name:speed}],display:{Name:Boots of Wally West}}",
                "/give ". @plr ." minecraft:iron_boots 1 8:30 4:30 name:&4S&ep&4e&ce&ed&8s&0t&9e&1r_&4Boots"                
            )
        )

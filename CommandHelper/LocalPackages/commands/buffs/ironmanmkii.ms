@plr = player()



@hero = associative_array(
            'name': '§7Iron §fMan §0MKII',
            'class': 'ironmanmkii',
            'sig': 'J6w16TBvsa1VT5PVwz8LtYxhU9uVZZJNCw5ns36Tezz2eJ3jHe7QhheTcgEcZTEu0wkwGMWdHjiQbp9FA6R6Pbtp0bbs+LcHqAwPiac3oRbrqMXDHZw0cDQcbgUqCxA3oufFD9rR635FridZW8f+60poeVkQtnFB/CLoh61YVfTWkHdqCSlWpI16g+s4IMXS+Cn8D3PYVyPbfRbSsyZAHkO/o0obRI95ZqJyLVsCi/5E72ARdOm5iadmSgPNVhXvtW5rAYsl9KMnLNGJdbZaSbs3xU08dn8EcxOsUoEoY4YK+85O4SHO+9yhq1ULdcHh5bqJ3iw+FH6A/K4fH2z3fgd96pbxLXvS+N5oV3fmh7EfVNrOmg2S+DivH/ouH/cnWcyWOZAKtYDGLzwvnGvou5ZR64+KxwRFUgX98QGQijjXelRv1hk1P0W0+D45zG01iHdJsul70Em0E4juMvOEg50EgLZ242gFcRm6V5hAF4X3c+TqIlF/jlnIXoDM24Yk8Iv5A/zD6oOgKJ1IR9EUIjlBzwlKeef1cJ2nkdIJFoIhmHtrOfj3Qp7JvHlEKT08CjO9V9dp31Ev+uoLuqqHtlTixwyoUMdogtR3qleyW5ZyNRIroO52lQyb+dpJhmr7Qva7BTMFF8G0q9L84+LzfMYaVNve4QJM94FNMC125sk=',
            'val': 'eyJ0aW1lc3RhbXAiOjE1MDAxODA5MDY1MDAsInByb2ZpbGVJZCI6IjU5NzU0YTRkMjVmNTRlZjNhZjk0ZDNmMGU1OGFmYjhjIiwicHJvZmlsZU5hbWUiOiJpaVdlYWtuZXNzIiwic2lnbmF0dXJlUmVxdWlyZWQiOnRydWUsInRleHR1cmVzIjp7IlNLSU4iOnsidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS8zZTcyODI3ZTlkNGYyNzBmODljNzA5OGFmYzllNmU0OTRiYjNhOTFiM2RjNTY4Yzc2NjcyMmEyMDcxZjQ1OCJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "With great power comes great responsibility.",
            'powers': array(
                "/buff",
                "/carryplayer",
                "/dismountplayer",
                "/jump 0-5",
                "/run 0-6",
                "/haste 0-6",
                "/fly",
                "/flyspeed 0-10"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 6 true",
                "/effect ". @plr ." 11 9999 2 true",
                "/effect ". @plr ." 13 9999 1 true",
                "/effect ". @plr ." 16 9999 1 true",
                "/effect ". @plr ." 21 9999 14 true",                
                "/shot give ". @plr ." ironmansmachinegun",
                "/shot give ". @plr ." ironmanshomingmissile",
                "/shot give ". @plr ." quantumlaser"
            )
        )

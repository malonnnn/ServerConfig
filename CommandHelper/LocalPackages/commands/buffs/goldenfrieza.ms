@plr = player()



@hero = associative_array(
            'name': '§5Gol§eden Frieza',
            'class': 'goldenfrieza',
            'sig': 'T5tvTqnMAe9u1g0N9QynZ5MnLocpjjmjjBpYU+LDl7I4kGsJ7Hfn+2xKy+8aCTAe5WsN3hVzXtonmOs4ji8NTzC2tilOPeoqdAL48+m0iGvjDEBmJRTT4JAlcQKwfDGIYYJ2I1mNVTV7y29HoH3EkV6Y1jyM0qOeq+iHGygRcWlkSWad8xHtMlFAzvLiz8qNTswMwLmLhmDyMELnysL01KCOOc94ye8aprnplAjrrrOmmixxIpzdD2tyQUqfhpkU/b9nKmCW9naQZvF9OIW8HHfCKnLAWQNXQmy9yROu9ru1mCZBv8R2fHfyfv4EIuZtj8ovLPJwVIKgjEaQvF3JksTcxkwSH72wnFfbMsvtFE+lAp7wjpzKiWxZ2NTQ8k6OrfGKp3ogma2jhTHhzUaZI5KRGvjw/EVlFfi3gP0JkbhKAinBD2D50/o6xk/90Z2a1YRW9cgT9fJdOTuOXMwQEjv3FwpbJ4l7o2yqwGhsZi6CZgbgKGkqVZZcGxEBxbzk07jXNhIgbqKu6mUR6Ywx4lVMzR62NwEwtLkEAeLXkSWzsnuV05Oms/rGYCAnd6HcjsOfFFXNzhMJ0RKmEMx8yaEfwk2n/X/q0Y6o0LKQ3oJvO6YqnxBUB8Fy7SRO2iPDGBQxIiQYLuQnPzrWWOTS/puVLB8bnDAlVn0RCVJsRXo=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NzQ3NzI0MTQxMjIsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzcyMTM4NjI2MmM3Y2Q3MmY3MjUyYWY0MWE4MWVlY2NlNDExYWJmZmE1YmViMjVjY2IwZDA1NTE3MmQ3MmE4MCJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "You thought you destroyed me!?!",
            'powers': array(
                "/buff",
                "/jump 0-9",
                "/run 0-9",
                "/haste 0-9",
                "/flyspeed <number>",
                "/fly",
                "/carryplayer <player>",
                "/dismountplayer"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 19 true",
                "/effect ". @plr ." 10 9999 1 true",
                "/effect ". @plr ." 11 9999 3 true",
                "/effect ". @plr ." 12 9999 1 true",
                "/effect ". @plr ." 13 9999 1 true",
                "/effect ". @plr ." 21 9999 19 true",
                "/shot give ". @plr ." goldenfriezaenergyblast",
                "/shot give ". @plr ." kiblast"
            )
        )

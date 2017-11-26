@plr = player()




@hero = associative_array(
            'name': '§2L§aa§2sh§ae§2r',
            'class': 'lasher',
            'sig': 'SgVZstz5KMFww+EwXlF5YV2cP/pTSNPn8jsQBXsF8QUvZHvXKlrLr3BPiptcm4Ms1CpsfkIa7RmMlEktZa5vH4V5yCshEa5RsGsaaVyN4owpMpHD962QuJsy7jvjs1KnEQEYPwiPkUrOLJvXQmwJu/ps8KrZUNuVRrzE+thG/t1tmsPX1zSQ+YzEVWLsTMKMWuUCVvrtUw2XKBeUzO48YXzqAWXJwiOmpjL/t21StvwB1SWuENhuFAe+Im569l8xi3xFMNwM0C/Mku1Qfaz0mU822BhomVYq6czd9XskiI6KToj1Ex5G7Eet5gkMYZIJ7FefkKDfvJ9U9Vc0DHVTnZLj5KS2F/3E1sjHcAmdaCVGfnJEKMdksMEbmSrToowXt3EgGFnnsVrqEKDjD10NlsohVbOMpHaSfQ5iI0np5opfT/MZPNZ6hqUO3p3HbqUexsS/TQalb2u9HfE6YWHGEId5fsL1Sby8OXMw1Ysi+oKOOxgg8CsBYA4vCzD1NGoR6QBU8Yejd33TQqD7Abmfahd2Xud+oGsQ6Ya3H3IjyHPj9Qm3zkLeSQaSaUto80yMTM0572WZOerSs8nzl+4EcIcBfnQnummj1q7s7xhtDFRBqBe7cjzJouZFavo3CMNZ7zqenbopGcKOSf+t/DAhCLd4fvlBvQRphQ+ZCrx9S18=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NzY2NTI1ODMwOTAsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2EyMmExMWE3NWFlODYwZmYzYTlhNDk2YWQyMTdlNmY4MTdjYzdhZmY0ODg1MzcyMzM4NDUyNmU1NDMxZGMyIn19fQ==',
            'trail': '',
            'op': 'false',
            'speech': "I am Lasher!",
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
                "/give ". @plr ." minecraft:web 64",
                "/shot give ". @plr ." webshot"
            )
        )

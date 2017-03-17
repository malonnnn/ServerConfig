@plr = player()


@hero = associative_array(
            'name': '§8Wint§7er §4Sol§cdier',
            'class': 'wintersoldier',
            'sig': 'yhYZMmyqgziPRbzTREjFvRKVkhyAR0wAi8yviOBUYdy+TZxsXypTy0Am8MaTZlMIwIlD2jy4eAL/B7xUmoFAoJv5QSqcTJ9iJJh9BpHCXSNqTh5J6Ju7txoGh3LlUCbhGhF1gghpGsJl4DzyRZ8XVKZsHGYiXqZnygKDtwDV/+Z+oHCFnT0/+o/BXsPzbFU3KmATRTQt0tGaNj3O8RxE5zpfwi4E308XGDtG48+t85oG8uiSv1aCzgKL/y4pv56jSSXkZdi/crSf/dr8mQ1KWXHvC9kBMXR/P5mTylSaelo/pYBAvfmkYvMLipFs7BBHfrL92+LqnjUBYHVsarpGaed/hdaGKhkjQ5QJXBxBXR5kHcQT9q7q8+GIY5GiwlKQ+7WPHHeFYm5/K8MYlXTOIjUKR6mYddCOY+4DT1VZk4O9btY+VoBSGEkY+3VNfuYHlSp2BNBct3ggVOvKASbTXYhHiRKvzG2UKeBq6qJJNrZ4/mgPQD4vy94D0DU0cTh7TQB01ZYehM7nwHN1dH9RXOGdZ+rRbbKpEbXUPoSMNtwTWOMzNfsCj5YrSlUn0VVJnUmRttm33Gm7mUSIMG2ucnvdvul4ar1LPPv7zP6bZlaxKzh6hJwWvl3XY785KEsDirF/PPp2js6l+7j3JIPQBLAjInlgA7He7cxzcJGlr6k=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NzQ1MTE1MDg3MDQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzM2YjNmZjVhNWY2ODhiM2U2MDhmOTY0NDllNWU1OGUyODkzYThhNGFmYmM2Mjg0ODFmZjRhNzIzZWM3MzIifX19',
            'trail': '',
            'op': 'false',
            'speech': "Soldier ready to serve.",
            'powers': array(
                "/buff",
                "/jump 0-5",
                "/run 0-4",
                "/haste 0-4"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 8 true",
                "/effect ". @plr ." 21 9999 4 true",
                "/shot give ". @plr ." pistol",
                "/shot give ". @plr ." AK-47",
                "/shot give ". @plr ." Hunting",
                "/shot give ". @plr ." Olympia",
                "/shot give ". @plr ." Python",
                "/shot give ". @plr ." Gauss",
                "/shot give ". @plr ." Putty",
                "/shot give ". @plr ." Grenade",
                "/shot give ". @plr ." C4"                
            )
        )
@plr = player()



@hero = associative_array(
            'name': '§eN§6aruto',
            'class': 'naruto',
            'sig': 'fRJ45wSY4k4rNR683M5CxI+7hcl3g7q1xfdWNU4hL9NmN0lLrmVgxkdgDOmeZlUTzQKP03Z2zDc11Jw5yPhs1FHct62uU+pEldSNNCI/X1cPHS+8KmpiACLroBzXvd/+nmoytf5c1zvveh6FphhgixsNVINvMaMR9TKDhdJKBdnKY1/XPIjHHW7Rh7KGAr4WfVyUYbiNKyz0mRSfxMttUpJ0xZoPj1cz9wZq9pn17BCiuhjTTVXGOdZ5x6I4i6bTblb87vE74g5KYoBqaSiKjI0dPSTaSdmIXjNf2liu2S7x1ZdytjlJIyDENWDee8naAMIsff8qX9zG82+EpPhgNN+WOW4KHXb3j7hCZo4oRlgIhPHl8TdmHmwgag1WkA54z877wERQ+qKvST1GuLAVxEnXxSf1k7joyaw4AinCx8h4X74abLsHFbAzrGmIjndDxLH+9AKZi4lidPdQK8yCKKbgx41nMHRNpqi9omqNoiCo9oCfp9Q6fNv7NrMwXCkRXAQBhQS/ATOXzT3u4KiZYirTVgPOLGZ8gH8cEDWP60VsHuRxfog5gbffEL4HkBgMoUpf2I4fPG4PYOL07+QixRpbJNiLM8DvYf7oke7LSHeoCiD0AtoFE0XbS3nQND7oGcCS8SV/LsbqwhRwLEfEdHebLO2Un3hHJ/lsJHtVnik=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NjQ3NjY3OTEzODQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzM3YmRiOWIxMjc2MDhhMzdhZGNmNzQ3MjU1ZDYyODQwYTI2MTc4M2YzZDY0YzZjNmJkNjViOTUzZGEzNjllN2MifX19',
            'trail': '',
            'op': 'false',
            'speech': "I am a Ninja!",
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

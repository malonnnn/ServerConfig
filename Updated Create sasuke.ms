@plr = player()
 
 
 @hero = associative_array(
             'name': '§5S§0a§5s§0u§5k§0e',
             'class': 'sasuke',
             'sig': 'xLxmSXobx/qnMh2aifqVSsJ/TBIn3poZoOG6FPlu+qT0K9OCjyIRKNFVmsnzAalpflG754I1Ix85yF78pMQ/fiV00KFMiD4HsOPNi/C87l1zZXlfOcFpqIsGsnPPTv9d1S7GzMnw5soAHQBckR1JIl+wP1KgIsXYCVbw7lVRYMc+sfoWLf1eXgsGiyeMFMje9hTLxZjg0aL5mpcd2pWqrv1t1sGVhKtpqv38DkatW6EKUZacStx3ef7/AhvmLLd6AEzTPd2K/8sTBid+yMEJc+fbadK65Au768srGaGmglPpaj6RpHXQju0CwmsTbea+cEc8GQy2uGoXMIowluCjdY53GeFe4JIBnrOAV+A9i4jfli05jlBtgrL3zhKeqUwbEUnScrhebYlKDEiM/wLFDmkwu/35/CdV/w5U2lhKUM/qn3r7kPgJiyZCXCMbacNzxUrZtk6Tq+nbE6NrDY+F3amgIw01EexndKnOcAdrj52Y7vL5QNliWW5gEkrBDPthFRO7mUDY8rXKFIFVoJSNgzViXHGWo3UrSPL26yZVypMhStuANlZiid7sWWupsFUD/5tzCcH+h/aWLBj7/FoOtr5MFRoL4I3nOHjxMyxv7vq7qcocyyk+xll6BtSWR+binkU7rYAJEuo3XPiRqijiJOu38BMlGaTwiM8WgqCB9EY=',
             'val': 'eyJ0aW1lc3RhbXAiOjE1MDkyMzg4Mzg0NTMsInByb2ZpbGVJZCI6IjRiZDIyNTQyZmM0MDQyZGViOTRjMjAzOWI0MjYyNTliIiwicHJvZmlsZU5hbWUiOiJzdGFybG9yZDIwMTYiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2M2YWVmMTg2NGJlZGRlOWViN2RhN2NjYzRhMjcyZjg2MzUzMzE4YzdiNTFlZmNiZTMyNGUzMmZjYWJjY2E4In19fQ',
             'trail': '',
             'op': 'false',
             'speech':"I will kill my brother.",
             'powers': array(
                 "/buff",
                 "/jump 0-6",
                 "/run 0-7", 
                 "/haste 0-5",
                 "/mindcontrol <playername>"
                 "/forcechocke <playername>",
                 "/thru",
                 "when you punch a player empty handed, your victim is stuck by lightning (force lightning)"
              ),
              'buffs': array(
                  "/effect ". @plr ." 5 9999 15 true", 
                  "/effect ". @plr ." 10 9999 15 true",
                  "/give ". @plr ." minecraft:iron_sword 1 16:75 19:9 name:&5S&0a&5s&0u&5k&0e&5s_&5K&0a&5t&0a&5n&0a",
                  "/give ". @plr ." minecraft:iron_boots 1 9:2 name:&5S&0a&5s&0u&5k&0e&5s_&5S&0l&5i&0p&5p&0e&5r&0s",
                  "/effect ". @plr ." 11 9999 10 true",
                  "/effect ". @plr ." 25 9999 5 true", 
                  "/effect ". @plr ." 21 9999 9 true",
              )
         )

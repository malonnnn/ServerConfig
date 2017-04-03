@plr = player() 
 
 
 
 
 @hero = associative_array( 
             'name': '§bIce§1man', 
             'class': 'iceman', 
             'sig': 'rxDiZKYFE0dzwuPg4D52q24+jGnwv57A0TKSe1Vfw0+S4PkA0sMzWhthS4WSWesgLQhu/ELhwzF/yJhFyjYQuSE72MxpsOsAlVE8My9jjll2KREQ3+eEi02AeACvE/7Usbns95T54e458btni6tuVlM3JfC78/B/68G3oxzK23xNUjnYf9Q1OI/+d+F3lt87uzii23ay+/S9jjl75F4uaQ0LAC1I0Lp2qRx7phlSdecdjyGU7u5tWjAULj/q0JlkR+88CXMvY4kNJqdPYFxJOgMfGrSWIJ5sZTMRiJKzcIwaX+WGHrAHxfuJBxuzFtMmw/wIgqe8OajqmhWixPJLOAUu0Lqsme0rAhj4j6uBluzz54Xx4KF5LWJYXwT1YGneSUq+2VtFuoq6zqW0W+JJid7scwqoCZdHFBYzWx6FEIgkmkzY2kvXvuyf9npDKMmR+7aOiVWvEaloDPI8Rq2+BjEPDK5vixw/wa6KNB8Q+ZeUFv6XskKgYKmsIRCzAk/eBJmDHr9Jd801+IeGfjzsR0br2ibGPI6HlLnDmbe42NdsVqAh1FAKKZKyyFjU+JduabyG4brx26y9g7dnwinSJ87cxrdbF8AyigrmsSVSAw/O0Zv2p4FjIapkpOg4NI6WI5mvKcZOfnwXOWI+kThJ4/c6WptE5dEb/yvmfKoVK+U=', 
             'val': 'eyJ0aW1lc3RhbXAiOjE0OTEyMzg1MDk3ODMsInByb2ZpbGVJZCI6ImY2MjE1ODZlOGVmODQ0OGQ5MjY0ODZiNjEzNzUwNTJlIiwicHJvZmlsZU5hbWUiOiJteXRoZ3V5MTIyNiIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZjk4ZGQyNWM2NTIxYjM0M2JkMzcwNzg0ODdjZTJmYTZjNGNmYjFhY2JjZTFkMzM3MWFmYWJhOGI5ZjU5ZDYifX19', 
             'trail': '', 
             'op': 'false', 
             'speech': "Chill out!", 
             'powers': array( 
                 "/buff",  
                 "/run 0-2" 
             ), 
             'buffs': array( 
                 "/effect ". @plr ." 5 9999 2 true", 
                 "/effect ". @plr ." 21 9999 9 true",  
                 "/shot give ". @plr ." icespike",
                 "/give ". @plr ." minecraft:elytra 1 70:1 34:3 name:&b&lIce_Glide"
             ) 
         ) 

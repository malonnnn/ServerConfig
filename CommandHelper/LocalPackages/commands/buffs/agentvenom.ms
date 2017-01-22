@plr = player()


@hero = associative_array(
            'name': '§8Ag§0ent §8Ve§0nom',
            'class': 'agentvenom',
            'sig': 'B9vAGgvt5rMSD8+8kFRt0uAIV2nLOePLYrzmrUTnJb/0K8SmEY90EuKkijU1uKLoHPhY1rf1G8fJgldEN0LNBfE5sgdD5pEslR/ikpRcOAqSI+n0gNaz3E/akMR0Sqrdh5BIYgOGsLm0UB++I+Q4Vid/NBC1lkxntMm3y8rdsyH5od+OpJBc+1NeSd4FTC94Rp6OueWz9sbM8RddeG5rQDDPVyMe0w5cSP08cbbZZYFtgaSelFMeCQ9PdxFqIvKEIoHheWKFj5P9mlU130cLrNiXMxAtm7mma8q7iMb2OSS/N9I0gCZd+d1+z2atLuNNVqJlcrEALJKfb3RvmGJ/reGeu/O2sTWRz2yjQSgU9KQYVtb3/2OY+T9lJ/2J/7PEjwX90oL14vgxa9l3+EO1T0isUOlbWRy8SsXMdY9DYZeTEyBAiCZeEBJlGH3a31T7S4s/hJSmHS/DV/WmoraBmrU1HGn5x9bVOs8r8cUZ+IbfeZLmAhMNRMC98elzyyai4Td9Z1B4xM4SD3N/kSp7+TLfZgFfEoqt3xg+w+W7MDvfat9VmxmOR2yUY16IUxbkcyNCUSqJOzqqWNcZWM5T0fq/Z1kmBNs1BXHVtXG72p7kVzBEz8EZKpGnzrbY9UzOStasesOEas1R23Ydz+dv1wcrO4AhEL/2J7EO2F64PlM=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0ODUwNTE1NjIyMTksInByb2ZpbGVJZCI6IjQwODdiYzdmYzIxMzQ3ZGZiZjJkNDE2NTAwMzBiZTQ1IiwicHJvZmlsZU5hbWUiOiJVbHRyYU93bERDIiwic2lnbmF0dXJlUmVxdWlyZWQiOnRydWUsInRleHR1cmVzIjp7IlNLSU4iOnsidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS82YTM0YTczZTZmNzUyOGEyN2UxNmQ1MGI1NjI0NjMyMWZkNmE5NDgxZWM1ZDdkYzVlZDVjYjc5OTY0N2VmYSJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "Now I Can be Like Spiderman!",
            'powers': array(
                "/buff",
                "/jump 0-7",
                "/run 0-5",
                "/carryplayer",
                "/dismountplayer",
                "/haste 0-4",
                "/web",
                "/websling"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 15 true",
                "/effect ". @plr ." 10 9999 2 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/give ". @plr ." minecraft:web 64",
                "/shot give ". @plr ." webshot"
            )
        )

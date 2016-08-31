proc(_friendlyHeroName, @class,
    
    @fname = ''

    if(@class == 'doctormanhattan'){        
        @fname = '§bD§3o§bct§3o§br §bM§3a§bnhatt§3a§bn'
    }
    else if(@class == 'deadpool'){
        @fname = '§4D§0ea§4dp§0oo§4l'
    }
    else if(@class == 'greenarrow'){
        @fname = '§2Gre§0e§2n A§0r§2row'
    }
    else if(@class == 'captainamerica'){
        @fname = '§4C§9apt§fain §4A§9mer§4ica'
    }
    else if(@class == 'mystique'){
        @fname = '§1Mystique'
    }
    else if(@class == 'blackwidow'){
        @fname = '§5B§0lac§5k §5W§0ido§5w'
    }
    else if(@class == 'speedy'){
        @fname = '§4Sp§eee§4dy'
    }
    else if(@class == 'raven'){
        @fname = '§5R§0a§5v§0e§5n'
    }
    else if(@class == 'blackpanther'){
        @fname = '§0Black Panther'
    }
    else if(@class == 'hawkeye'){
        @fname = '§8H§0a§8w§0k§8e§0y§8e'
    }
    else if(@class == 'robin'){
        @fname = '§cR§eo§cbi§2n'
    }
    else if(@class == 'aphrodite'){
        @fname = '§dAphrodite'
    }
    else if(@class == 'athena'){
        @fname = '§fA§9then§fa'
    }
    else if(@class == 'demeter'){
        @fname = '§aD§2e§am§2e§at§2e§ar'
    }
    else if(@class == 'dionysus'){
        @fname = '§aDi§2on§ay§2sus'
    }
    else if(@class == 'hera'){
        @fname = '§bH§3er§ba'
    }
    else if(@class == 'hermes'){
        @fname = '§eH§6e§er§6m§ee§6s'
    }
    else if(@class == 'hestia'){
        @fname = '§6Hes§4tia'
    }
    else if(@class == 'blackcanary'){
        @fname = '§0Black Canary'
    }
    else if(@class == 'hercules'){
        @fname = '§6Herc§9ules'
    }
    else if(@class == 'wolverine'){
        @fname = '§eW§0o§elv§9er§eine'
    }
    else if(@class == 'spiderman'){
        @fname = '§4Sp§fi§4d§0e§4rm§0a§4n'
    }
    else if(@class == 'thehumantorch'){
        @fname = '§fThe §eHum§6an §cTor§4ch'
    }
    else if(@class == 'antman'){
        @fname = '§4A§0n§4t-M§0a§4n'
    }
    else if(@class == 'darthvader'){
        @fname = '§8D§0a§8r§0t§8h V§0ade§8r'
    }
    else if(@class == 'darthmaul'){
        @fname = '§4D§0a§4r§0t§4h M§0au§4l'
    }
    else if(@class == 'darthsidious'){
        @fname = '§0Darth Sidious'
    }
    else if(@class == 'cyborg'){
        @fname = '§7C§by§8b§4o§7r§8g'
    }
    else if(@class == 'starfire'){
        @fname = '§dS§5t§4a§drf§5i§4r§de'
    }
    else if(@class == 'apollo'){
        @fname = '§eA§fp§eo§fll§eo'
    }
    else if(@class == 'artemis'){
        @fname = '§9A§2r§9t§2e§9m§2i§9s'
    }
    else if(@class == 'blackspiderman'){
        @fname = '§8Bl§0a§8ck Sp§fi§8derm§0a§8n'
    }
    else if(@class == 'nightwing'){
        @fname = '§1N§0igh§1tw§0in§1g'
    }
    else if(@class == 'superman'){
        @fname = '§cS§9u§ep§9e§9rm§can'
    }
    else if(@class == 'hulk'){
        @fname = '§a§lH§2§lULK'
    }
    else if(@class == 'wonderwoman'){
        @fname = '§4W§fon§eder §4W§fom§9an'
    }
    else if(@class == 'bartallen'){
        @fname = '§4Fl§ea§4sh-BartA'
    }
    else if(@class == 'batman'){
        @fname = '§7B§ea§0t§7m§8a§7n'
    }
    else if(@class == 'ironman'){
        @fname = '§6I§4r§bo§4n M§6an'
    }
    else if(@class == 'ichigokurosaki'){
        @fname = '§6Ichi§0go §fKuro§0saki'
    }
    else if(@class == 'supergirl'){
        @fname = '§cS§9u§ep§9e§9rg§cirl'
    }
    else if(@class == 'storm'){
        @fname = '§8Storm'
    }
    else if(@class == 'ultron'){
        @fname = '§7Ul§8tr§4o§7n'
    }
    else if(@class == 'martianmanhunter'){
        @fname = '§2Mar§9t§2ian §9Man§2hunter'
    }
    else if(@class == 'warmachine'){
        @fname = '§7§lW§4§la§7§lr M§4§la§7§lch§9§li§7§lne'
    }
    else if(@class == 'hephaestus'){
        @fname = '§4H§0e§cph§0a§4est§cus'
    }
    else if(@class == 'zoom'){
        @fname = '§bZ§0oo§bm'
    }
    else if(@class == 'naruto'){
        @fname = '§eN§6aruto'
    }
    else if(@class == 'aquaman'){
        @fname = '§eA§6qua§2man'
    }
    else if(@class == 'haljordan'){
        @fname = '§2Gr§8e§2en Lant§8e§2rn-HJ'
    }
    else if(@class == 'lexluthor'){
        @fname = '§2L§9e§2x Luth§9o§2r'
    }
    else if(@class == 'thor'){
        @fname = '§eT§4h§9o§fr'
    }
    else if(@class == 'ares'){
        @fname = '§4§lAr§0§le§4§ls'
    }
    else if(@class == 'hades'){
        @fname = '§4Hades'
    }
    else if(@class == 'poseidon'){
        @fname = '§3P§9o§3s§9e§3i§9d§3o§9n'
    }
    else if(@class == 'goku'){
        @fname = '§eG§1o§6ku'
    }
    else if(@class == 'vegeta'){
        @fname = '§eV§fe§1ge§fta'
    }
    else if(@class == 'zeus'){
        @fname = '§fZ§eeu§fs'
    }
    else if(@class == 'doctorstrange'){
        @fname = '§cD§9octo§cr §9S§ctrang§9e'
    }
    else if(@class == 'boros'){
        @fname = '§dB§9oro§ds'
    }
    else if(@class == 'onepunchman'){
        @fname = '§6One §fPunch §4Man'
    }
    else if(@class == 'kidflash'){
        @fname = '§eK§4i§ed §4F§el§4a§es§4h'
    }
    else if(@class == 'howardtheduck'){
        @fname = '§eHoward §6the §fDuck'
    }
    else if(@class == 'magneto'){
        @fname = '§4M§5a§4g§5n§4e§5t§4o'
    }
    else if(@class == 'daredevil'){
        @fname = '§4D§care§4d§cevil'
    }
    else if(@class == 'reverseflash'){
        @fname = '§eRe§4v§eerse Fl§4a§esh'
    }
    else if(@class == 'blackadam'){
        @fname = '§8Bl§ea§8ck §8Ad§ea§8m'
    }
    else if(@class == 'shazam'){
        @fname = '§fS§ch§ea§fz§ca§em'
    }
    else if(@class == 'onslaughtreborn'){
        @fname = '§4Onsl§9aug§4ht Reb§9orn'
    }
    else if(@class == 'niteowl'){
        @fname = '§8N§ci§8te O§7w§8l'
    }
    else if(@class == 'doomsday'){
        @fname = '§D§foo§7msd§4a§7y'
    }
    else if(@class == 'thanos'){
        @fname = '§7§5Th§ea§9n§eo§9s'
    }
    else if(@class == 'galactus'){
        @fname = '§5G§9a§0l§5a§9c§0t§5u§9s'
    }
    else if(@class == 'greengoblin'){
        @fname = '§2Gr§5ee§2n G§5o§2blin'
    }
    else if(@class == 'wallywest'){
        @fname = '§4Fl§ea§4sh-WW'
    }
    else if(@class == 'sonicthehedgehog'){
        @fname = '§9S§fo§9n§4i§9c t§fh§9e H§fe§9dge§4h§fo§4g'
    }
    else if(@class == 'generalzod'){
        @fname = '§8Gen§7e§8ral Z§7o§8d'
    }
    else if(@class == 'fang'){
        @fname = '§8F§7a§8n§7g'
    }
    else if(@class == 'alanscott'){
        @fname = '§2Gr§8e§2en Lant§8e§2rn-AS'
    }
    else if(@class == 'kentnelson'){
        @fname = '§6D§9o§6ct§9o§6r F§9a§6te-KN'
    }
    else if(@class == 'parallaxentity'){
        @fname = '§eParallax §6Entity'
    }
    else if(@class == 'barryallen'){
        @fname = '§4Fl§ea§4sh-BarryA'
    }
    else if(@class == 'mrmxyzptlk'){
        @fname = '§6M§5r§6. §5M§6x§5y§6z§5p§6t§5l§6k'
    }
    else if(@class == 'blackbolt'){
        @fname = '§8B§7l§0a§8ck B§0o§7l§8t'
    }
    else if(@class == 'deathstroke'){
        @fname = '§8Death§6stroke'
    else if(@class == 'firefly'){
        @fname = '§eF§4i§ere§8f§el§8y'
    else if(@class == 'Venom'){
        @fname = '§8Ve§fn§8om'
    }
    if(@fname != '')
    {
        return(@fname)
    }
    return("false")
)
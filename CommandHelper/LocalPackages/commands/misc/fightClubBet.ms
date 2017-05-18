register_command(fightclubbet, 

	array(
	
		description: 'Places a bet on a player that is Fighting in Fight Club',
		
		usage: '/fightclubbet <amount> <player>',
		
		permission: 'ch.alias.fightclubbet',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command.',
		
		aliases: 'bet',
		
		tabcompleter: closure(@alias, @sender, @args) {
            try{
				if(array_size(@args) == 0) {
					return(all_players());
				}
				@search = @args[array_size(@args) - 1];
					return(array_filter(all_players(), closure(@index, @player) {
					return(equals_ic(@search, substr(@player, 0, length(@search))));
				}));
			} catch (RangeException @ErrorInfo) {
				# Ignore
			}
        },
	
		executor: closure(@alias, @sender, @args) {
		
				if (array_size(@args) != 2) {
				
					msg(''.color(RED).color(BOLD).'Improper Usage!');
					msg(''.color(RED).'Usage: /fightclubbet <amount>  <player>');
					die(); # No need to go further					
				
				}		
				
				@plr = player()

				@pendingFight = import('fightClubStatus')
				@activeFight = import('fightClubActive')
				
				if(@pendingFight == 'closed'){
					if(@activeFight != 'true'){
						@p1 = import('fightClubFighter1')
						@p2 = import('fightClubFighter2')

						@amt = @args[0]
						if(@amt < 1){
							tmsg(@plr,color(red).'Sorry, your bet must be at least 1!')
							die()
						}
						@bal = acc_balance(@plr)

						if(@amt > @bal){
							tmsg(@plr,color(red).'Sorry, you don\'t have enough money!')
							die()
						}

						if(@amt > 1000){
							tmsg(@plr,color(red).'Sorry, the max bet is 1000')
							die()
						}

						@personBetOn = @args[1]
						@personBetOn = player(@personBetOn)

						if(@personBetOn != @p1 && @personBetOn != @p2){
							tmsg(@plr,color(red).'Sorry, neither of those players are fighting right now!')
							die()
						}
						@opponent = import(@plr.'fcvs')
						if(@personBetOn == @opponent){
							tmsg(@plr,color(red).'Sorry, you are not allowed to bet on your opponent!')
							die()
						}

						assign(@cooldown, 10)
						
						assign(@lastUsedFightClubBet, import(@plr."lastUsedFightClubBet"))
						if(@lastUsedFightClubBet + @cooldown > time() / 1000,
							assign(@timeleft, subtract(add(@lastUsedFightClubBet, @cooldown), divide(time(),1000)))
							tmsg(@plr,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can change your bet!'))
							die()
						)
						export(@plr."lastUsedFightClubBet", time() / 1000)
						export(@plr.'fightClubBetPerson',@personBetOn)
						export(@plr.'fightClubBetAmt',@amt)

						tmsg(@plr,color(red).'You have bet $'.color(white).@amt.color(red).' on '.color(white).@personBetOn)
						broadcast(@plr.color(red).' bet $'.color(white).@amt.color(red).' on '.color(white).@personBetOn.color(red).'!')
					}else{
						tmsg(@plr,color(red).'Sorry, you cannot bet while a fight is active!')
					}
				}else{
					tmsg(@plr,color(red).'Sorry, no pending fights to bet on right now right now!')
				}	
		
		}
	)
)

register_command(officialfight, 

	array(
	
		description: 'Records a Fight Club \'Fight\' as an Offical Match. Influences Players Fighting Stats',
		
		usage: '/officialfight',
		
		permission: 'ch.alias.officialfight',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command.',
	
		executor: closure() {
		
				@pendingFight = import('fightClubStatus')

				@ref = player()
				if(@pendingFight == 'closed'){
					tmsg(@ref,color(red).'Whoops! Too late!')
					die()
				}

				@ref = player()
				@winner = import('fightClubLastWinner')
				@loser = import('fightClubLastLoser')

				if(@winner != null && @winner != '' && @loser != null && @loser != ''){
					@plrs = all_players()

					@winnerWins = get_value(@winner.'fightClubWins')
					@winnerLosses = get_value(@winner.'fightClubLosses')
					@loserWins = get_value(@loser.'fightClubWins')
					@loserLosses = get_value(@loser.'fightClubLosses')
					@winnerMultiplier = 1
					@loserMultiplier = 1

					if(@winnerWins == null || @winnerWins == ''){
						@winnerWins = 0
					}
					if(@winnerLosses == null || @winnerLosses == ''){
						@winnerLosses = 0
					}
					if(@loserWins == null || @loserWins == ''){
						@loserWins = 0
					}
					if(@loserLosses == null || @loserLosses == ''){
						@loserLosses = 0
					}

					if(@winnerWins == 0){
						if(@winnerLosses == 0){
						   #if first fight
						   @winnerMultiplier = 1 
						}else{
							#if some losses and 1st win
							@winnerMultiplier = @winnerLosses
						}
					}else{
						if(@winnerLosses == 0){
							#if some wins and no losses
							@winnerMultiplier = 1 / @winnerWins
						}else{
							#if some wins and some losses
							@winnerMultiplier = @winnerLosses / @winnerWins
						}
					}

					if(@loserLosses == 0){
						if(@loserWins == 0){
						   #if first fight
						   @loserMultiplier = 1 
						}else{
							#if undefeated and 1st loss
							@loserMultipiler = 1 / @loserWins
						}
					}else{
						if(@loserWins == 0){
							#if no wins some losses
							@loserMultiplier = @loserLosses
						}else{
							#if some wins and some losses
							@loserMultiplier = @loserLosses / @loserWins
						}
					}
					@multiplier = @winnerMultiplier / @loserMultiplier

					foreach(@plr in @plrs){
						@personBetOn = import(@plr.'fightClubBetPerson')
						@amt = import(@plr.'fightClubBetAmt')

						if(@personBetOn != null && @personBetOn != '' && @amt != null && @amt != ''){
							if(@personBetOn == @winner){
								@winAmt = round(@amt * @multiplier,2)
								acc_add(@plr,@winAmt)
								broadcast(@plr.color(green).' won $'.@winAmt.' from betting at Fight Club!')
							}else if(@personBetOn == @loser){
								@bal = acc_balance(@plr)
								if(@amt > @bal){
									tmsg(@ref,@plr.' '.color(red).' does not have '.color(white).@amt.color(red).'!')
									continue()
								}
								acc_subtract(@plr,@amt)
								broadcast(@plr.color(dark_red).' lost $'.@amt.' from betting at Fight Club!')
							}
						}
						export(@plr.'fightClubBetPerson','')
						export(@plr.'fightClubBetAmt','')
					}

					@winnerWins += 1
					@loserLosses += 1
					export('fightClubLastWinner','')
					export('fightClubLastLoser','')
					acc_add(@winner,100)
					acc_add(@loser,50)
					store_value(@winner.'fightClubWins',@winnerWins)
					store_value(@loser.'fightClubLosses',@loserLosses)
					broadcast(color(dark_red).'Official Fight!'.color(green).' $100 '.color(red).'for '.color(white).@winner.color(red).' and '.color(green).'$50 '.color(red).'for '.color(white).@loser)
				}else{
					tmsg(@ref,color(red).'The previous fight was either already paid out or hasn\'t started yet!')
				}
		
				
		
		}
	)
)

register_command(setwins, 

	array(
	
		description: 'Sets the amount of a wins a Player Has',
		
		usage: '/setwins <wins> <player>',
		
		permission: 'ch.alias.setwins',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command.',
		
		tabcompleter: closure(@alias, @sender, @args) {
            try{
				if(array_size(@args) == 0) {
					return(all_players());
				}
				@search = @args[array_size(@args) - 1];
					return(array_filter(all_players(), closure(@index, @player) {
					return(equals_ic(@search, substr(@player, 0, length(@search))));
				}));
			} catch (RangeException @ErrorInfo) {
				# Ignore
			}
        },
	
		executor: closure(@alias, @sender, @args) {
		
				if (array_size(@args) != 2) {
				
					msg(''.color(RED).color(BOLD).'Improper Usage!');
					msg(''.color(RED).'Usage: /setwins <amount>  <player>');
					die(); # No need to go further					
				
				}
				
				@num = @args[0]
				@person = @args[1]

				store_value(@person.'fightClubWins',@num)
		
		}
	)
)

register_command(setlosses, 

	array(
	
		description: 'Sets the amount of a losses a Player Has',
		
		usage: '/setlosses <losses> <player>',
		
		permission: 'ch.alias.setlosses',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command.',
		
		tabcompleter: closure(@alias, @sender, @args) {
            try{
				if(array_size(@args) == 0) {
					return(all_players());
				}
				@search = @args[array_size(@args) - 1];
					return(array_filter(all_players(), closure(@index, @player) {
					return(equals_ic(@search, substr(@player, 0, length(@search))));
				}));
			} catch (RangeException @ErrorInfo) {
				# Ignore
			}
        },
	
		executor: closure(@alias, @sender, @args) {
		
				if (array_size(@args) != 2) {
				
					msg(''.color(RED).color(BOLD).'Improper Usage!');
					msg(''.color(RED).'Usage: /setwins <amount>  <player>');
					die(); # No need to go further					
				
				}
				
				@num = @args[0]
				@person = @args[1]

				store_value(@person.'fightClubLosses',@num)
		
		}
	)
)

register_command(resetfightstats, 

	array(
	
		description: 'Resets a players fight stats',
		
		usage: '/resetfightstats <player>',
		
		permission: 'ch.alias.resetfightstats',
		
		noPermMsg: 'Sorry you don\'t have permission to use this command.',
		
		tabcompleter: closure(@alias, @sender, @args) {
            try{
				if(array_size(@args) == 0) {
					return(all_players());
				}
				@search = @args[array_size(@args) - 1];
					return(array_filter(all_players(), closure(@index, @player) {
					return(equals_ic(@search, substr(@player, 0, length(@search))));
				}));
			} catch (RangeException @ErrorInfo) {
				# Ignore
			}
        },
	
		executor: closure(@alias, @sender, @args) {
		
				if (array_size(@args) != 1) {
				
					msg(''.color(RED).color(BOLD).'Improper Usage!');
					msg(''.color(RED).'Usage: /resetfightstats <player>');
					die(); # No need to go further					
				
				}
				
				@plr = player(@args[0])
				store_value(@plr.'fightClubWins',0)
				store_value(@plr.'fightClubLosses',0)

    tmsg(player(),@plr.color(red).'\'s Fight Club stats were reset!')
		
		}
	)
)

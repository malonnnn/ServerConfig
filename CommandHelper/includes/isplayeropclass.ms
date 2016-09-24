proc(_isPlayerOpClass, @player,
    @pgroup = pgroup(@player)
    if(
        @pgroup[0] == 'doctormanhattan' ||
        @pgroup[0] == 'zeus' ||
        @pgroup[0] == 'poseidon' ||
        @pgroup[0] == 'hades' ||
        @pgroup[0] == 'onepunchman' ||
        @pgroup[0] == 'wallywest' ||
        @pgroup[0] == 'onslaughtreborn' ||
        @pgroup[0] == 'kentnelson' ||
        @pgroup[0] == 'mrmxyzptlk' ||
        @pgroup[0] == 'supermanprimeonemillion' ||
        @pgroup[0] == 'onslaughtreborn'
    ){
        return("true")
    }
    
)
proc(_getWorldByID, @id, 

    if(@id == '1'){
        return(associative_array(
            'id': '1',
            'name': '',
            'world': 'metropolis'
        ))
    }
    else if(@id == '2'){
        return(associative_array(
            'id': '2',
            'name': '',
            'class': 'gotham'
        ))
    }
    else if(@id == '3'){
        return(associative_array(
            'id': '3',
            'name': '',
            'class': 'infinitycity'
        ))
    }
    else if(@id == '4'){
        return(associative_array(
            'id': '4',
            'name': '§eTi§at§dan§5s To§dw§eer',
            'class': 'titantower'
        ))
    }
    else if(@id == '5'){
        return(associative_array(
            'id': '5',
            'name': '§4Ha§fll §9Of §4Just§fi§9ce',
            'class': 'hallofjustice'
        ))
    }
    else if(@id == '6'){
        return(associative_array(
            'id': '6',
            'name': '§bF§fo§brtr§fe§bss §fof §bS§fo§blit§fu§bde',
            'class': 'fortressofsolitude'
        ))
    }
    
    return(associative_array(
        'id': '',
        'name': '<open slot>',
        'class': ''
    ))
)

//
//  StatesViewModel.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/5/20.
//

import UIKit

class StatesViewModel {
    
    let stateModel = States()
    
    var introTitle: String {
        return stateModel.introTitle
    }
    
    var buttonTitle: String {
        return stateModel.buttonTitle
    }
    

    func dispayStatesSearchResults(isSearching: Bool, searchText: String) -> [String] {
        var results = [String]()
        let count = searchText.count
        let statesDictionary = StateHelper.states.compactMap({$0.value})
        
        if isSearching {
            let searchResults = statesDictionary.filter({$0.prefix(count).lowercased() == searchText}).sorted()
            results = searchResults
        } else {
            results = statesDictionary.sorted()
            
        }
        return results
        
    }
}




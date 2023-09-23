//
//  AllSportsViewModel.swift
//  SportsApp
//
//  Created by Ali on 30/04/2022.
//

import Foundation

class AllSportsViewModel {
    var allSportsService: AllSportsService!
    var allSportsData : AllSports! {
        didSet {
            self.bindMoviesViewModelToView()
        }
    }
    
    var showError : String! {
        didSet{
            self.bindViewModelErrorToView()
        }
    }
       
    var bindMoviesViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
     init() {
        self.allSportsService = AllSportsService()
        self.fetchAllSportsDataFromAPI()
    }
    
    func fetchAllSportsDataFromAPI (){
        allSportsService.fatchDataFromAPI() { (allSportsData, error) in
            if let error = error {
                let message = error.localizedDescription
                self.showError = message
            } else {
                self.allSportsData = allSportsData
            }
        }
    
    }
}

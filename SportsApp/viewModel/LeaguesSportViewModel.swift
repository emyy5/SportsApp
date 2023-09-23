//
//  LeaguesSportViewModel.swift
//  SportsApp
//
//  Created by Eman khaled on 21/07/2023.
//

import Foundation
import Alamofire
class LeaguesSportViewModel{
    var leaguesSportsService: AllSportsService!
    var sport:MySport
    var sportError:String?
    var league:[Leagus]?{
        didSet{
            self.bindLeaguesToView()
        }
    }
    var bindLeaguesToView : (()->()) = {}
    var bindLeaguesErrorToView : (()->()) = {}
    init(sport:MySport){
        self.sport = sport
        self.leaguesSportsService = AllSportsService()
        self.fetchSportLeaguesFromAPI()
    }
    func fetchSportLeaguesFromAPI (){
        leaguesSportsService.fatchDataItemsFromAPI(url: Constants.getLeaguesBySportName(sportName: sport.strSport), typeItem: LeaguesResult.self) { (allSportsData, error) in
            if let error = error {
                let message = error.localizedDescription
                self.sportError = message
                print(message)
            } else {
                self.league = allSportsData?.countrys as? [Leagus]
            }
        }
    }
}

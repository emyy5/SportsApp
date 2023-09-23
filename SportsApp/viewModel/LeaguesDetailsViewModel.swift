//
//  LeaguesDetailsViewModel.swift
//  SportsApp
//
//  Created by Eman khaled on 21/07/2023.
//

import Foundation
import CoreData
class LeaguesDetailViewModel {
    var allSportsService: AllSportsService!
    var coreDataService:CoreDataService!
    var leagues:Leagus
    var allTeamsData : TeamsResult! {
        didSet {
            self.bindLeaguesTeamsToView()
        }
    }
    var showTeamsError : String! {
        didSet{
            self.bindLeaguesTeamsErrorToView()
        }
    }
    var allUpcomingData : LeaguesLatestEvent! {
        didSet {
            self.bindLeaguesUpcomingToView()
        }
    }
    var showUpcomingError : String! {
        didSet{
            self.bindLeaguesUpcomingErrorToView()
        }
    }
    var allLatestData : LeaguesLatestResult! {
        didSet {
            self.bindLeaguesLatestToView()
        }
    }
    var showLatestError : String! {
        didSet{
            self.bindLeaguesLatestErrorToView()
        }
    }
    
    var bindLeaguesLatestToView : (()->()) = {}
    var bindLeaguesLatestErrorToView : (()->()) = {}
    var bindLeaguesUpcomingToView : (()->()) = {}
    var bindLeaguesUpcomingErrorToView : (()->()) = {}
    var bindLeaguesTeamsToView : (()->()) = {}
    var bindLeaguesTeamsErrorToView : (()->()) = {}
    var favouriteIcon:String{
        didSet{
            self.updateFavState()
        }
    }
    var updateFavState: (()->()) = {}
    init(leagues:Leagus) {
        self.leagues = leagues
        self.allSportsService = AllSportsService()
        self.favouriteIcon = "heart"
        self.fetchLeaguesTeamsFromAPI()
        self.fetchLeaguesLatestResultFromAPI()
        self.fetchLeaguesUpcomingEventsFromAPI()
        self.coreDataService  = CoreDataService()
    }
    //working correctly
    func fetchLeaguesTeamsFromAPI (){
        allSportsService.fatchDataItemsFromAPI(url: Constants.getLeaguesTeams(leagues: leagues.strLeague), typeItem: TeamsResult.self) { (allSportsData, error) in
            if let error = error {
                let message = error.localizedDescription
                self.showTeamsError = message
            } else {
                self.allTeamsData = allSportsData
            }
        }
    }
    //the link not working properly
    func fetchLeaguesUpcomingEventsFromAPI (){
        allSportsService.fatchDataItemsFromAPI(url: Constants.getLeaguesUpcomingEvent(leaguesID: Int(leagues.idLeague)!) , typeItem: LeaguesLatestEvent.self) { (allSportsData, error) in
            if let error = error {
                let message = error.localizedDescription
                self.showUpcomingError = message
            } else {
                self.allUpcomingData = allSportsData
                
            }
        }
    }
    func fetchLeaguesLatestResultFromAPI (){
        allSportsService.fatchDataItemsFromAPI(url: Constants.getLeaguesLatestResultEvent(leaguesID: Int(leagues.idLeague)!) , typeItem: LeaguesLatestResult.self) { (allSportsData, error) in
            if let error = error {
                let message = error.localizedDescription
                self.showUpcomingError = message
            } else {
                self.allLatestData = allSportsData
            }
        }
    }
    func toggleFav(appDelegate:AppDelegate){
        if(favouriteIcon == "heart"){
            addToFavourite(appDelegate: appDelegate)
           self.favouriteIcon = "heart_fill"
        }else{
            removeFromFav(appDelegate: appDelegate)
            self.favouriteIcon = "heart"
        }
    }
    func addToFavourite(appDelegate:AppDelegate){
        coreDataService.saveToRoom(appDelegate: appDelegate , item: leagues)
    }
    func removeFromFav(appDelegate:AppDelegate){
        coreDataService.removeLeagueFromCoreData(appDelegate: appDelegate , l: leagues){
            self.favouriteIcon = "heart"
        }
    }
    func getFavouriteIcon(appDelegate:AppDelegate)->String{
        coreDataService.getSingleLeagueFromCoreData(appDelegate: appDelegate, l: leagues){ (result) in
            guard result != nil else {return}
            if(result?.countrys.count != 0){
                self.favouriteIcon = "heart_fill"
            }
        }
        return favouriteIcon
    }
}

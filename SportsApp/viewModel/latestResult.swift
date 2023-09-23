//
//  latestResult.swift
//  SportsApp
//
//  Created by Ali on 03/05/2022.
//

import Foundation
struct LeaguesLatestResult:Decodable {
    let events:[EventResult]
}
struct EventResult:Decodable{
    let idEvent:String
    let strHomeTeam:String
    let strAwayTeam:String
    let strTime:String
    let dateEvent:String
    let intHomeScore:String
    let intAwayScore:String
    let strThumb:String
}

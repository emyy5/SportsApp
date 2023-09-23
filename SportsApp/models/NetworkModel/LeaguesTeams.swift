//
//  LeaguesTeams.swift
//  SportsApp
//
//  Created by Ali on 02/05/2022.
//

import Foundation
struct TeamsResult:Decodable {
    var teams:[Team]
}
struct Team:Decodable{
    let idTeam:String
    let strTeam:String
    let strTeamBadge:String
    let strStadiumThumb:String?
    let strStadium:String
    let strSport:String
    let strLeague:String
    let strStadiumDescription:String?
    let strDescriptionEN:String?
}

//
//  LeaguesUpcomingEvents.swift
//  SportsApp
//
//  Created by Rain Moustfa on 03/05/2022.
//

import Foundation
struct LeaguesLatestEvent:Decodable {
    var events:[Event]
}
struct Event:Decodable{
    let idEvent:String
    let strEvent:String
    let strTimestamp:String
}

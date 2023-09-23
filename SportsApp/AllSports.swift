//
//  AllSports.swift
//  SportsApp
//
//  Created by Ali on 30/04/2022.
//

import Foundation

struct MySport: Decodable {
    let idSport: String
    let strSport: String
    let strFormat: String
    let strSportThumb: String
    let strSportIconGreen: String
    let strSportDescription: String
}

struct AllSports: Decodable {
    let sports: [MySport]
}


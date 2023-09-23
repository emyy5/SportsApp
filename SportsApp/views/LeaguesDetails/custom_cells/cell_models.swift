//
//  cell_models.swift
//  SportsApp
//
//  Created by Eman khaled on 21/07/2023.
//

import Foundation
enum CellModel{
    case collectionViewItem(models: [Team], rows:Int)
    case list(models: [EventResult])
}

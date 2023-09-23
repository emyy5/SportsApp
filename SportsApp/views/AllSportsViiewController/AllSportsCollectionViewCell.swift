//
//  AllSportsCollectionViewCell.swift
//  SportsApp
//
//  Created by Eman khaled on 21/07/2023.
//

import UIKit

class AllSportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var allSportImageView: UIImageView!
    
    @IBOutlet weak var sportName: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        allSportImageView.image = nil
    }
    
    
}

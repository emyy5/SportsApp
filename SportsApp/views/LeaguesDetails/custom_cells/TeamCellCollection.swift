//
//  TeamCellCollection.swift
//  SportsApp
//
//  Created by Eman khaled on 21/07/2023.
//

import Foundation
import UIKit
import SDWebImage
class TeamCellCollection:UICollectionViewCell{
    static let identifier = "tableCollectionViewCell"
    let label:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    let imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.addSubview(imageView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 5, y: 5,
                                 width: contentView.frame.size.width-10 ,
                                 height: contentView.frame.size.height-5-50)
        label.frame = CGRect(x: 5,
                             y: contentView.frame.size.height-5-50,
                             width: contentView.frame.size.width-10 ,
                                 height: 50)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with model:Team){
        label.text = model.strTeam
        imageView.sd_setImage(with: URL(string: model.strTeamBadge) )
    }
}

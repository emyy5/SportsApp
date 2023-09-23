//
//  LeaguesTableViewCell.swift
//  SportsApp
//
//  Created by Eman khaled on 21/07/2023.
//

import Foundation
import UIKit
class LeaguesTableViewCell: UITableViewCell{
    static let identifier = "LeaguesTableViewCell"
    let leagueTitle:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    let leagueBadge:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    let leagueSport:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    let youtubeImageLink:UIButton = {
        let youtubeImageLink = UIButton()
        return youtubeImageLink
    }()
    var actionBlock: (() -> Void)? = nil
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leagueBadge)
        contentView.addSubview(leagueTitle)
        contentView.addSubview(youtubeImageLink)
        contentView.addSubview(leagueSport)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        leagueBadge.frame = CGRect(x: 4, y: 4,
                                 width: 70 ,
                                 height: 70)
        leagueTitle.frame = CGRect(x: 75,
                             y: 4,
                             width: contentView.frame.size.width-120 ,
                                 height: 40)
        leagueSport.frame = CGRect(x: 75,
                             y: 50,
                             width: contentView.frame.size.width-120 ,
                                 height: 30)
        youtubeImageLink.frame = CGRect(x: contentView.frame.size.width-50,
                                        y: 4, width: 50, height: 40)
        youtubeImageLink.setImage(UIImage(named: "youtube"), for: .normal)
        youtubeImageLink.addTarget(self, action: "openLink", for: .touchUpInside)
    }
    var myModel:Leagus?
    public func configure(with model:Leagus){
        leagueTitle.text = model.strLeague
        leagueBadge.sd_setImage(with: URL(string: model.strBadge) )
        leagueSport.text = model.strSport
        
    }
    
    @objc func openLink(){
        actionBlock?()
    }
}

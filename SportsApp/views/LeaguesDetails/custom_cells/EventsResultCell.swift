//
//  EventsResultCell.swift
//  SportsApp
//
//  Created by Eman khaled on 21/07/2023.
//

import UIKit

class EventsResultCell: UITableViewCell {
    static let identifier = "EventsResultCell"
    let hostTeam:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    let remoteTeam:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    let eventThumb:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    let teamsScoreResult:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(hostTeam)
        contentView.addSubview(remoteTeam)
        contentView.addSubview(eventThumb)
        contentView.addSubview(teamsScoreResult)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        eventThumb.frame = CGRect(x: 4, y: 4,
                                  width: contentView.frame.width-4, height: 75)
        hostTeam.frame = CGRect(x: 4, y: 80,
                                width: contentView.frame.width/3 , height: 15)
        remoteTeam.frame = CGRect(x: contentView.frame.width*2/3 - CGFloat(4) , y: 80,
                                  width: contentView.frame.width/3, height: 15)
        teamsScoreResult.frame = CGRect(x: contentView.frame.width/3 + CGFloat(4),
                                        y: 80,
                                        width: (contentView.frame.width/3)-CGFloat(4) ,
                                        height: 15)
    }
    public func configure(with model:EventResult){
        eventThumb.sd_setImage(with: URL(string: model.strThumb ?? ""))
        remoteTeam.text = model.strAwayTeam
        hostTeam.text = model.strHomeTeam
        teamsScoreResult.text = "\(model.intHomeScore):\(model.intAwayScore)"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.layoutMargins = UIEdgeInsets.zero //or UIEdgeInsetsMake(top, left, bottom, right)
        self.separatorInset = UIEdgeInsets.zero //if you also want to adjust separatorInset
    }
}

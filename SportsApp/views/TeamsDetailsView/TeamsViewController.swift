//
//  TeamsViewController.swift
//  SportsApp
//
//  Created by Eman khaled on 21/07/2023.
//

import UIKit
import SDWebImage

class TeamsViewController: UIViewController {
    var team:Team?
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var stadioName: UILabel!
    @IBOutlet weak var studioImage: UIImageView!
    @IBOutlet weak var aboutTeam: UILabel!
    @IBOutlet weak var sportName: UILabel!
    @IBOutlet weak var legueName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //makeImageRounded()
        if let team = team {
            self.title = team.strTeam
            logoImage.sd_setImage(with: URL(string: team.strTeamBadge))
            studioImage.sd_setImage(with: URL(string: team.strStadiumThumb ?? ""))
            stadioName.text = team.strStadium
            aboutTeam.text = team.strDescriptionEN
            sportName.text = team.strSport
            legueName.text = team.strLeague
        }
    }
    func setTeam(team:Team){
        self.team  = team
        print(team)
    }
    func makeImageRounded(){
        logoImage.layer.borderWidth = 1
        logoImage.layer.masksToBounds = false
        logoImage.layer.borderColor = UIColor.black.cgColor
        logoImage.layer.cornerRadius = logoImage.frame.height/2
        logoImage.clipsToBounds = true
    }
    
}

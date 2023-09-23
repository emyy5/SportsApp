//
//  LeaguesSportTableViewController.swift
//  SportsApp
//
//  Created by Eman khaled on 21/07/2023.
//

import UIKit

class LeaguesSportTableViewController: UITableViewController {
    var leagusViewModels:LeaguesSportViewModel?
    var models = [Leagus]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(LeaguesTableViewCell.self , forCellReuseIdentifier:"cell")
        readLeagues()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell
        cell.leagueTitle.text = models[indexPath.row].strLeague
        cell.leagueSport.text = models[indexPath.row].strSport
        cell.leagueBadge.sd_setImage(with: URL(string: models[indexPath.row].strBadge) )
        cell.actionBlock = {
            guard let subUrl = self.models[indexPath.row].strYoutube
            else{
                print("null")
                return
            }
            let url = "http://\(subUrl)"
            print( url)
            UIApplication.shared.open(URL(string: url)!)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentReachabilityStatus == .notReachable {
            showDialoug()
        } else {
            let LegueDetail = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesDetailsViewController") as! LeaguesDetailsViewController
            LegueDetail.league = models[indexPath.row]
            LegueDetail.shouldUpdateView = true
            self.navigationController?.pushViewController(LegueDetail, animated: true)
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func setSport(sport:MySport){
        leagusViewModels  = LeaguesSportViewModel(sport: sport)
        self.title = "\(sport.strSport) Leagues"
    }
    func readLeagues(){
        guard let leagusViewModels = leagusViewModels else {
            return
        }
        leagusViewModels.bindLeaguesToView = {
            self.models = leagusViewModels.league ?? [Leagus]()
            self.tableView.reloadData()
        }
    }
    func showDialoug(){
        let alert = UIAlertController (title: "No Connection!", message: "sorry there's no Internet Connection to Display Leagues details", preferredStyle: UIAlertController.Style.alert )
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

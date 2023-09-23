//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by Eman khaled on 21/07/2023.
//

import UIKit
import SDWebImage
import Alamofire
class FavoriteViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource {

    @IBOutlet weak var leaguesTable: UITableView!
    let viewModel = LeagueViewModel(appDelegate: (UIApplication.shared.delegate as? AppDelegate)!)
    var leagues = [Leagus]()
    var currentSelectedItem:Leagus?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favourite Leagues"
        leaguesTable.register( LeaguesTableViewCell.self, forCellReuseIdentifier: LeaguesTableViewCell.identifier )
        leagues = viewModel.favLeaguesData.countrys
        leaguesTable.delegate = self
        leaguesTable.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getFavLeagues()
        leagues = viewModel.favLeaguesData.countrys
        leaguesTable.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let leaguesDetail = segue.destination as! LeaguesDetailsViewController
        guard let  indexPath = sender as? IndexPath else { return }
        leaguesDetail.league = leagues[indexPath.row]
        leaguesDetail.shouldUpdateView = true
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if currentReachabilityStatus == .notReachable {
            showDialoug()
            return false
        } else {
           return false
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeaguesTableViewCell.identifier, for: indexPath) as! LeaguesTableViewCell
        cell.leagueTitle.text = leagues[indexPath.row].strLeague
        cell.leagueSport.text = leagues[indexPath.row].strSport
        cell.leagueBadge.sd_setImage(with: URL(string: leagues[indexPath.row].strBadge) )
        cell.actionBlock = {
            guard let subUrl = self.leagues[indexPath.row].strYoutube
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showLeaguesDetails", sender: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func showDialoug(){
        let alert = UIAlertController (title: "No Connection!", message: "sorry there's no Internet Connection to Display Leagues details", preferredStyle: UIAlertController.Style.alert )
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

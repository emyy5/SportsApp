//
//  TableView.swift
//  SportsApp
//
//  Created by Rain Moustfa on 05/05/2022.
//

import Foundation
import UIKit

extension LeaguesDetailsViewController :UITableViewDelegate ,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch models[section]{
        case .list(let models):
            if models.count > 10{
                return 10
            }
            else  {
                return models.count
            }
        case .collectionViewItem(let models,_): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.section]{
        case .list(let models):
            let cell = tableView.dequeueReusableCell(withIdentifier: EventsResultCell.identifier, for: indexPath) as! EventsResultCell
            cell.configure(with: models[indexPath.row])
            return cell
        case .collectionViewItem(let models, _ ) :
            let cell = tableView.dequeueReusableCell(withIdentifier: LatestEventCellTable.identifier, for: indexPath) as! LatestEventCellTable
            cell.navigateToTeamDetails = { (team) in
                var teamViewController = self.storyboard?.instantiateViewController(withIdentifier: "TeamsViewController") as! TeamsViewController
                teamViewController.setTeam(team: team)
                self.navigationController?.pushViewController(teamViewController, animated: true)
            }
            cell.configure(with: models)
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 0: return "Latest Events"
        case 1: return "Teams"
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch models[indexPath.section]{
        case .list(_): return 120
        case .collectionViewItem(_ , let rows): return 180*CGFloat(rows)
        }
    }
    func navigateToTeams(team:Team){
        var LegueDetail = self.storyboard?.instantiateViewController(withIdentifier: "TeamsViewController") as! TeamsViewController
        LegueDetail.setTeam(team: team)
        self.navigationController?.pushViewController(LegueDetail, animated: true)
    }
}

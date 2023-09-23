//
//  LeaguesDetailsViewController.swift
//  SportsApp
//
//  Created by Eman khaled on 21/07/2023.
//

import Foundation
import UIKit
import SDWebImage

class LeaguesDetailsViewController: UIViewController {
    var leaguesDetail:LeaguesDetailViewModel?
    var league:Leagus?
    var appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
    var shouldUpdateView:Bool = false{
        didSet{
            leaguesDetail = LeaguesDetailViewModel(leagues: league!)
        }
    }
    private let table :UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(EventsResultCell.self, forCellReuseIdentifier: EventsResultCell.identifier)
        table.register(LatestEventCellTable.self, forCellReuseIdentifier: LatestEventCellTable.identifier)
        return table
    }()
    var models:[CellModel] = [.list(models: [EventResult]()),.collectionViewItem(models: [Team](), rows: 1)]
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModelCallingBack()
        self.title = league?.strLeague
        if(shouldUpdateView == true){
            self.title = league?.strLeague
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(
                    named:(leaguesDetail?.getFavouriteIcon(appDelegate:appDelegate))!), style: .plain,
                target: self, action: #selector(addToFavourite))
        }else{
            
        }
        
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    @objc func addToFavourite(){
        leaguesDetail?.toggleFav(appDelegate: appDelegate)
    }
    
    func initViewModelCallingBack(){
        leaguesDetail?.bindLeaguesTeamsToView = {
            self.models[1]=(.collectionViewItem(models: (self.leaguesDetail?.allTeamsData.teams)!, rows: 1)
            )
            self.table.reloadData()
        }
        leaguesDetail?.bindLeaguesLatestToView = {
            self.models[0] = (.list(models: (self.leaguesDetail?.allLatestData.events)!))
            self.table.reloadData()
        }
        if(shouldUpdateView == true){
            leaguesDetail?.updateFavState = {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    image: UIImage(
                        named:(self.leaguesDetail?.favouriteIcon)!), style: .plain,
                    target: self, action: #selector(self.addToFavourite))
            }
        }
    }
}

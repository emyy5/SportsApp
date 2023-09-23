//
//  ViewController.swift
//  SportsApp
//
//  Created by Eman khaled on 21/07/2023.
//

import UIKit
import SDWebImage
import Alamofire

class AllSportsViewController: UIViewController {
    @IBOutlet weak var allSportsCollectionView: UICollectionView!
    let allSportsViewModel = AllSportsViewModel()
    var allSportsData: [MySport] = []
    var allSports: AllSports?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sports"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allSportsViewModel.bindMoviesViewModelToView = {
            self.onSuccessUpdateView()
        }
        
        allSportsViewModel.bindViewModelErrorToView = {
            self.onFailUpdateView()
        }
    }

    func onSuccessUpdateView(){
        allSports = allSportsViewModel.allSportsData
        allSportsData = allSports!.sports
        self.allSportsCollectionView.reloadData()
    }
    
    func onFailUpdateView(){
        let alert = UIAlertController(title: "Error", message: allSportsViewModel.showError, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
        
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension AllSportsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allSportsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allSportsCell", for: indexPath) as! AllSportsCollectionViewCell
        
        cell.sportName.text = allSportsData[indexPath.row].strSport
        cell.allSportImageView.sd_setImage(with: URL(string: allSportsData[indexPath.row].strSportThumb))
        cell.allSportImageView.layer.cornerRadius = 25
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let side = (view.frame.size.width - 16.0 )/2
            return CGSize(width: side, height: side)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var sportLegue = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesSportTableViewController") as! LeaguesSportTableViewController
        sportLegue.setSport(sport: allSportsData[indexPath.row])
        self.navigationController?.pushViewController(sportLegue, animated: true)
    }
}

//
//  AllSportsService.swift
//  SportsApp
//
//  Created by Eman khaled on 21/07/2023.
//

import Foundation
import Alamofire

class AllSportsService {
    
    func fatchDataFromAPI(completionHandler: @escaping (AllSports?, Error?) -> Void){
        AF.request(Constants.getAllSportsURL).responseDecodable(of: AllSports.self)  { (response) in
            switch response.result {
            case let .success(data):
                completionHandler(data, nil)
            case let .failure(error):
                completionHandler(nil, error)
            }
        }
    }
    
    
    func fatchDataItemsFromAPI<T:Decodable>(url:String ,typeItem:  T.Type ,completionHandler: @escaping ( T? , Error?) -> Void){
        AF.request(url).responseDecodable(of: T.self )  { (response) in
            switch response.result {
            case let .success(data):
                completionHandler(data, nil)
            case let .failure(error):
                completionHandler(nil, error)
            }
        }
    }
    
}

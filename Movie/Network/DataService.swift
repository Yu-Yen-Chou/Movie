//
//  DataService.swift
//  Movie
//
//  Created by Yen on 2020/2/9.
//  Copyright © 2020 Yen. All rights reserved.
//

import Foundation
import Alamofire
import Network


struct DataService {

   
    
// MARK: - Singleton
 static let shared = DataService()
let monitor = NWPathMonitor()
// MARK: - URL
  
   
   // private var Discover : String?
    
    func Https_Discover(Page:Int,sort_by:String,primary_release_date:String,completion: @escaping (M_Home?, Error?) -> ()){
                
                let  Discover_url = G_Base_Url + "/discover/movie?" + "api_key=\(G_API_Key)" + "&sort_by=\(sort_by)" + "&primary_release_date.lte=\(primary_release_date)" + "&page=\(Page)"
     
             Alamofire.request(Discover_url,method:.get).responseData{ response in
               
                      if let error = response.error
                      {
                          completion(nil, error)
                          return
                      }
                      if let result = response.value
                      {
                           var H_Model:M_Home?
                      
                       do {
                         
                           H_Model = try JSONDecoder().decode(M_Home.self, from: result)
                           
                           let encoder = JSONEncoder()
                           encoder.outputFormatting = .prettyPrinted
                           let encoded = try! encoder.encode(H_Model)
                           
                           print(String(data: encoded, encoding: .utf8)!)
                           
                          } catch {
                                  print(error)
                         }
             
                          completion(H_Model, nil)
                          return
                      }
                  
                  }
                  
                  
              }
       //
    func Https_Detail(id:Int,completion: @escaping (M_Detail?, Error?) -> ()){
                   //http://api.themoviedb.org/3/movie/328111?api_key=328c283cd27bd1877d9 080ccb1604c91
                   let  Detail_url = G_Base_Url + "/movie" + "/\(id)" + "?api_key=\(G_API_Key)"
        
                Alamofire.request(Detail_url,method:.get).responseData{ response in
                  
                         if let error = response.error
                         {
                             completion(nil, error)
                             return
                         }
                         if let result = response.value
                         {
                              var H_Model:M_Detail?
                         
                          do {
                            
                              H_Model = try JSONDecoder().decode(M_Detail.self, from: result)
                              
                              let encoder = JSONEncoder()
                              encoder.outputFormatting = .prettyPrinted
                              let encoded = try! encoder.encode(H_Model)
                              
                              print(String(data: encoded, encoding: .utf8)!)
                              
                             } catch {
                                     print(error)
                            }
                
                             completion(H_Model, nil)
                             return
                         }
                     
                     }
                     
                     
                 }

        
        
}

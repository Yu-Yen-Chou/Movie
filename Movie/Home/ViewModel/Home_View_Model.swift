//
//  Home_View_Model.swift
//  Movie
//
//  Created by Yen on 2020/2/9.
//  Copyright © 2020 Yen. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher



class Home_View_Model: NSObject
{
// MARK: - parameter
    var end_Page = false
    var isLoading = false
    var total_pages:Int?
    var page_Num:Int = 1
    var items = [results_array]()
    {
        didSet{
         
          self.didFinishDiscover?()
        }
    }
    private var dataService: DataService?
 
// MARK: - Constructor
     init(dataService: DataService) {
       self.dataService = dataService
    }
    var model_home:M_Home?
    
    var error: Error? {
         didSet {
            //self.showAlertClosure?()
        }
     }

// MARK: - clousure
     var didFinishDiscover: (() -> ())?
     var didTapcell: (() -> ())?
    
// MARK: - Network call
    func Movie_Discover(Page: Int,sort_by:String,release_date:String)
    {
           self.dataService?.Https_Discover(Page: Page, sort_by: sort_by, primary_release_date: release_date,completion: { (M_Home, error) in
                
                if let error = error
                {
                    self.error = error
                    
                    return
                }
                self.error = nil
                 self.isLoading = false
            
                self.model_home = M_Home

                if let model_home = M_Home
                {
                    self.Parse_data(M_Home:model_home,Page: Page)
                }else
                {
                     print("model_home nil")
                }
           })
     }
    
    func Parse_data(M_Home:M_Home,Page: Int)
    {
       if let pages = M_Home.total_pages
       {
           self.total_pages = pages
           if(Page <= self.total_pages!)
           {
               if(Page  == 1)
               {
                   self.items = (M_Home.results)!
               }
               else
               {
                   let result = (M_Home.results)!
                   for i in 0..<result.count
                   {
                       let result = M_Home.results
                       self.items.append(result![i])
                   }
                   
               }
           }
       }
       else
       {
           print("total_pages nil")
       }
                       
    }
    
    func loadMoreData()
    {
        if !self.isLoading
        {
            self.isLoading = true
            page_Num += 1
           if let All_Page = total_pages
           {
                if (page_Num <= All_Page)
                {
                    Movie_Discover(Page:page_Num, sort_by: G_sort_by, release_date: G_release_date)
                }else
                {
                    end_Page = true
                    self.didFinishDiscover?()
                }
            }
        }
    }
    
    func Change_Like(love:Double) -> String
    {
        if(love >= 1)
        {
            let testStr = String(love)
            return "\(String(testStr.prefix(3)))K Likes"
        }else
        {
            let testStr = String(love*1000)
            return "\(String(testStr.prefix(3))) Likes"
        }
    }
}

// MARK: - TableViewDelegate
extension Home_View_Model: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return items.count
        }
        else if section == 1
        {
            return end_Page ? 0 : 1
        } else {
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       if (indexPath.section == 0)
       {
           if let cell = tableView.dequeueReusableCell(withIdentifier:"Home_Cell_id", for: indexPath) as? Home_Cell
           {
//poster_path
                if  let  url_path = items[indexPath.row].poster_path
                {
                    let base_url = G_Imgurl + url_path
                    let articleUrl = URL(string: base_url)
                    cell.poster_img.kf.indicatorType = .activity
                    cell.poster_img.kf.setImage(with: articleUrl)
                }else
                {
                    cell.poster_img.image = UIImage(named: "No_Image")
                }
//title
                if  let  title_lab = items[indexPath.row].title
                {
                     cell.title_label.text = title_lab
                }else
                {
                     cell.title_label.text = ""
                }
//popularity
                if  let  love = items[indexPath.row].popularity
                {
                      cell.popularity.text = Change_Like(love: love)
                }else
                {
                     cell.popularity.text = "0"
                }
                    return cell
           }
        }
        else
        {
          if let cell = tableView.dequeueReusableCell(withIdentifier:"Loading_Cell_id", for: indexPath) as? Loading_Cell
           {
                cell.activityIndicator.startAnimating()
               
                return cell
            }
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
         if let movie_id = items[indexPath.row].id
         {
             G_Poster_path = items[indexPath.row].poster_path
             G_detail_id = movie_id
             self.didTapcell?()
         }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return 150.0 //Home_Cell height
        } else
        {
           return 70 //Loading Cell height
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
       let offsetY = scrollView.contentOffset.y
       let contentHeight = scrollView.contentSize.height
       if (offsetY > contentHeight - scrollView.frame.height ) && !isLoading
       {
           loadMoreData()
       }
     }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
          cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
          UIView.animate(withDuration: 0.25, animations: {
               cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
           })
    }
    

}



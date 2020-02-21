//
//  Detail_View_Model.swift
//  Movie
//
//  Created by Yen on 2020/2/9.
//  Copyright © 2020 Yen. All rights reserved.
//

import Foundation
import UIKit


enum type_error:Int
{
    case no_error
    case error_time
    case error_date
    case error_people
}

protocol Detail_View_Model_Delegate: AnyObject {
    func tableViewDidScroll(_ tableView: Detail_View_Model, radius: CGFloat , offsetY: CGFloat)
    func  show_alert(type:type_error)
}

class Detail_View_Model: NSObject
{
   
    weak var delegate: Detail_View_Model_Delegate?
    
    var title_items = [String]()
    var items = [String:String]()
    var poster_img = UIImageView()

     private var dataService: DataService?
    var Model_Detail:M_Detail?{
       didSet {
           self.didFinishDetail?()
         }
    }
       var error: Error? {
            didSet {
               //self.showAlertClosure?()
               
           }
        }
     // MARK: - Constructor
        init(dataService: DataService) {
          self.dataService = dataService
            
            people_str = nil
            time_str = nil
            date_str = nil
            time_type = nil
            
            select_people.removeAll()
            select_time.removeAll()
            select_date.removeAll()
       }
    
     var didFinishDetail: (() -> ())?
    
   // MARK: - Network call
    func Movie_Detail(id: Int)
    {
              self.dataService?.Https_Detail(id: id,completion: { (M_Detail, error) in
                  
                   if let error = error{
                       self.error = error
                     
                       return
                   }
                   self.error = nil
              
              
                 if let detail = M_Detail
                 {
//Synopsis
                    if let overview = detail.overview
                    {
                        if(String(overview).count != 0)
                        {
                            self.items["Synopsis"] = overview
                            self.title_items.append("Synopsis")
                           
                        }
                    }
//Language
                    if let language = detail.original_language
                    {
                        self.items["Language"] = language
                        self.title_items.append("Language")
                    }
//Duration
                    if let time = detail.runtime
                    {
                        self.items["Duration"] = String(time) + " min"
                        self.title_items.append("Duration")
                    }
//genres
                    var combine:String?
                    var combine_array = [String]()
                    if let genres_array = detail.genres
                    {
                        for i in 0..<genres_array.count
                        {
                            combine_array.append(genres_array[i].name!)
                        }
                        
                        combine = combine_array.joined(separator:",")
                    }
                    if let combine_str = combine
                    {
                        if(combine_str.count != 0)
                        {
                            self.items["Genres"] = combine_str
                            self.title_items.append("Genres")
                        }
                    }
                    
                    self.items["Date"] = ""
                    self.title_items.append("Date")
                    
                    self.items["People"] = ""
                    self.title_items.append("People")
                    
                    self.items["Time"] = ""
                    self.title_items.append("Time")
                    
                    self.items["Book"] = ""
                    self.title_items.append("Book")
                    
                     self.Model_Detail = M_Detail
                 }
              })
     }
     
}
// MARK: -  UITableView Delegate,DataSource
extension Detail_View_Model: UITableViewDataSource ,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(title_items[indexPath.row] == "Date"||title_items[indexPath.row] == "People"||title_items[indexPath.row] == "Book")
        {
            return 80.0 //Date_Cell height
        }
        else  if(title_items[indexPath.row] == "Time")
        {
           return 380.0 //Time_Cell height
        }
        else
        {
            return UITableView.automaticDimension
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
     if(title_items[indexPath.row] == "Synopsis")
      {
        if let cell = tableView.dequeueReusableCell(withIdentifier:String(describing: Overview_Cell.self), for: indexPath) as? Overview_Cell
        {
            
            cell.title.text = items[title_items[indexPath.row]]
             return cell
        }
      }
     else if(title_items[indexPath.row] == "Date")
      {
        if let cell = tableView.dequeueReusableCell(withIdentifier:String(describing: Date_Cell.self), for: indexPath) as? Date_Cell
        {
            return cell
        }
      }
      else if(title_items[indexPath.row] == "Time")
      {
        if let cell = tableView.dequeueReusableCell(withIdentifier:String(describing: Time_Cell.self), for: indexPath) as? Time_Cell
        {
            return cell
        }
      }
      else if(title_items[indexPath.row] == "People")
      {
        if let cell = tableView.dequeueReusableCell(withIdentifier:String(describing: People_Cell.self), for: indexPath) as? People_Cell
        {
            return cell
        }
      }
      else if(title_items[indexPath.row] == "Book")
      {
        if let cell = tableView.dequeueReusableCell(withIdentifier:String(describing: Book_Cell.self), for: indexPath) as? Book_Cell
        {
            return cell
        }
      }
      else
      {
           if let cell = tableView.dequeueReusableCell(withIdentifier:String(describing: Detail_Cell.self), for: indexPath) as? Detail_Cell
           {

            cell.title.text = title_items[indexPath.row]
            cell.detail.text = items[title_items[indexPath.row]]
              return cell
              
           }
        }

        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(title_items[indexPath.row] == "Book")
        {
            let error_label = detect_value_exist()
            guard delegate?.show_alert(type: error_label) != nil else
            {
                 return print("the delegate is not set")
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {

        let offsetY = scrollView.contentOffset.y
        let radius = -offsetY / CGFloat(headImageView_height)
        //print(offsetY)
        if (-offsetY > CGFloat(headImageView_height))//往下滑
        {
            self.delegate?.tableViewDidScroll(self, radius: radius, offsetY: offsetY)
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
       {
              cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
               UIView.animate(withDuration: 0.25, animations: {
                    cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
                })
       }

    
    func detect_value_exist()-> type_error
    {
        
        if let people = people_str ,let time = time_str ,let date = date_str ,let type = time_type
        {
            print (people + "people time =" + time + "type = " + type +  "date = " + date)
            return  .no_error
        }else
        {
            if (people_str == nil) {
                return   .error_people
            }
            else if (time_str == nil || time_type == nil) {
                return   .error_time
            }
            else {
                return  .error_date
            }
            //print(error_label!)
           
        }
       
    }
}




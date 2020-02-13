//
//  Detail_View.swift
//  Movie
//
//  Created by Yen on 2020/2/9.
//  Copyright © 2020 Yen. All rights reserved.
//

import UIKit
import Kingfisher
    
// MARK: - Delegate
extension Detail_View:Detail_View_Model_Delegate
{
    func show_alert(type: type_error) {
        if(type == .no_error)
        {
            showAlert(title: "notic", message: "success")
        }
        else if(type == .error_time)
        {
            showAlert(title: "notic", message: "Please select time")
        }
        else if(type == .error_date)
        {
            showAlert(title: "notic", message: "Please select date")
        }
        else if(type == .error_people)
        {
            showAlert(title: "notic", message: "Please select people")
        }
       
    }
    func showAlert(title:String,message:String)
    {
       let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
       let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               controller.addAction(okAction)
       present(controller, animated: true, completion: nil)
    }
   
    
    func tableViewDidScroll(_ tableView: Detail_View_Model, radius: CGFloat, offsetY: CGFloat)
    {
        Poster_img.transform = CGAffineTransform.init(scaleX: radius, y: radius)
        var frame = Poster_img.frame
        frame.origin.y = offsetY
        Poster_img.frame = frame
    }
}
class Detail_View: UIViewController {
    
// MARK: - parameter
    
    @IBOutlet weak var Detail_Tab: UITableView!
     
    fileprivate let ViewModel = Detail_View_Model(dataService: DataService())
    
    
    lazy var Poster_img: UIImageView =
    {
          let Poster_img = UIImageView()
          Poster_img.frame = CGRect.init(x: 0, y: -headImageView_height, width: Int(KScreenWidth), height:   headImageView_height)
          Poster_img.contentMode = .scaleAspectFill
          Poster_img.clipsToBounds = true
        
          return Poster_img
   }()
    
// MARK: - ViewLifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

      
        SetupTableView()
        AttemptDetail()
        SetPosterimg()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
             super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
    }
// MARK: -  Function
    func SetPosterimg()
    {
        if let  path = G_Poster_path
        {
//read cache img
           let base_url = G_Imgurl + path
           let articleUrl = URL(string: base_url)
           let imageResource = ImageResource(downloadURL: articleUrl!, cacheKey: base_url)
           Poster_img.kf.setImage(with: imageResource)
        }
        else
        {
            Poster_img.image = UIImage(named:"No_Image")
        }
    }
    
    func SetupTableView()
    {
//TableView setup
        
        Detail_Tab?.separatorStyle = .none
        Detail_Tab.backgroundColor = UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0)
        Detail_Tab?.dataSource = ViewModel
        Detail_Tab?.delegate = ViewModel
        ViewModel.delegate = self
        
//Cell register
        let DetailCell_Nib = UINib(nibName: String(describing: Detail_Cell.self), bundle: nil)
        Detail_Tab.register(DetailCell_Nib, forCellReuseIdentifier: String(describing: Detail_Cell.self))
        
        let Overview_Nib = UINib(nibName: String(describing: Overview_Cell.self), bundle: nil)
        Detail_Tab.register(Overview_Nib, forCellReuseIdentifier: String(describing: Overview_Cell.self))
        
        let Date_Nib = UINib(nibName: String(describing: Date_Cell.self), bundle: nil)
        Detail_Tab.register(Date_Nib, forCellReuseIdentifier: String(describing: Date_Cell.self))
        
        let Time_Nib = UINib(nibName: String(describing: Time_Cell.self), bundle: nil)
              Detail_Tab.register(Time_Nib, forCellReuseIdentifier: String(describing: Time_Cell.self))
        let People_Nib = UINib(nibName: String(describing: People_Cell.self), bundle: nil)
        Detail_Tab.register(People_Nib, forCellReuseIdentifier: String(describing: People_Cell.self))
        
        let Book_Nib = UINib(nibName: String(describing: Book_Cell.self), bundle: nil)
        Detail_Tab.register(Book_Nib, forCellReuseIdentifier: String(describing: Book_Cell.self))
        
//Dynamic cell
        Detail_Tab.estimatedRowHeight = 25.0
        Detail_Tab.rowHeight = UITableView.automaticDimension
        
//Tableviewview headImage set
        Detail_Tab.addSubview(self.Poster_img)
        Detail_Tab.contentInset = UIEdgeInsets(top: CGFloat(headImageView_height), left: 0, bottom: 0, right: 0)
     }
// MARK: -  Networking call
     func AttemptDetail()
     {
      
        if let d_id = G_detail_id
        {
             ViewModel.Movie_Detail(id: d_id)
        }
         
        ViewModel.didFinishDetail =
        {
           self.Detail_Tab.reloadData()
        }
          
    
     }
// MARK: -  Return view
     @IBAction func Back(_ sender: Any)
     {
          self.navigationController?.popViewController(animated: true)
     }
}

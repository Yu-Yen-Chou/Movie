//
//  Data_Cell.swift
//  Movie
//
//  Created by Yen on 2020/2/11.
//  Copyright © 2020 Yen. All rights reserved.
//

import UIKit

class Time_Cell: UITableViewCell {
   
    
 // MARK: -  parameter
    var IMX_Arr = ["10:20","11:20","13:20","14:20","15:20","16:20","17:20"]
    var times_array = [
    M_Time(title: "IMAX", time: ["11:10","12:20","15:30","17:40","19:50","22:00"]),
    M_Time(title: "Standard", time: ["10:30","11:40","12:40","13:50","14:50","16:00","14:50","17:00","18:10","18:35","19:10","20:20","20:50","21:20","22:30","23:10","23:40","00:40"])
   ]
   
    
    @IBOutlet weak var c_view: UICollectionView!
    @IBOutlet weak var bg_view: UIView!
    
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
// bg_view corner
        
        bg_view.layer.cornerRadius = 30
        bg_view.layer.masksToBounds = false
        bg_view.layer.shadowColor = UIColor.black.cgColor
        bg_view.layer.shadowOpacity = 0.5
        bg_view.layer.shadowOffset = CGSize(width: -1, height: 1)
        
// UICollectionViewFlowLayout
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize.height = self.frame.height - 100
        layout.itemSize.width = 100
        c_view.collectionViewLayout = layout
        

// UICollectionView cell register
        let C_Date_Nib = UINib(nibName: String(describing: C_Time_Cell.self), bundle: nil)
        c_view.register(C_Date_Nib, forCellWithReuseIdentifier: String(describing: C_Time_Cell.self))

// UICollectionView Header register
        let C_Header_Nib = UINib(nibName: String(describing: C_Header_View.self), bundle: nil)
        c_view.register(C_Header_Nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: C_Header_View.self))
        
//Delegate, DataSource
        
        c_view.delegate = self
        c_view.dataSource = self
        
//Header flowLayout
        if let flowLayout = c_view.collectionViewLayout as? UICollectionViewFlowLayout {
            //  flowLayout.estimatedItemSize = CGSize(width: 50,height: 40)
            flowLayout.headerReferenceSize = CGSize(width: 50, height: 40)
        }
        

        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
// MARK: -  UICollectionView Delegate,DataSource
extension Time_Cell:UICollectionViewDelegate, UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
           return times_array.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
           return times_array[section].time.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: C_Time_Cell.self), for: indexPath) as! C_Time_Cell

            let T_time = times_array[indexPath.section] //time
            Cell.title.text = T_time.time[indexPath.row]
        
            if  select_time[indexPath.section] == indexPath.row
            {
                Cell.bg_view.backgroundColor = .red
            }
            else
            {
                Cell.bg_view.backgroundColor = .gray
            }
            return Cell
    }

//header view
     func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView
     {

        switch kind
        {
            case UICollectionView.elementKindSectionHeader:
                let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: C_Header_View.self), for: indexPath) as! C_Header_View

                reusableview.title.text = times_array[indexPath.section].title
                   return reusableview


            default:  fatalError("Unexpected element kind")
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      
         select_time.removeAll()
         select_time[indexPath.section] = indexPath.row
         time_type = times_array[indexPath.section].title
         time_str = times_array[indexPath.section].time[indexPath.row]
         c_view.reloadData()
    }
}

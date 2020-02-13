//
//  Data_Cell.swift
//  Movie
//
//  Created by Yen on 2020/2/11.
//  Copyright © 2020 Yen. All rights reserved.
//

import UIKit

class People_Cell: UITableViewCell
{
 // MARK: -  parameter
    
    var people_arr = ["1","2","3","4","5","6","7","8","9","10"]
   
    
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
        layout.scrollDirection = .horizontal
        layout.itemSize.height = self.frame.height - 100
        layout.itemSize.width = 50
        c_view.collectionViewLayout = layout
        

 // UICollectionView register
        
        let C_Date_Nib = UINib(nibName: String(describing: C_Num_Cell.self), bundle: nil)
        c_view.register(C_Date_Nib, forCellWithReuseIdentifier: String(describing: C_Num_Cell.self))
        
// UICollectionView Header register
        
        let C_Header_Nib = UINib(nibName: String(describing: C_Header_View.self), bundle: nil)
        c_view.register(C_Header_Nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: C_Header_View.self))
        
//Header flowLayout
        
        if let flowLayout = c_view.collectionViewLayout as? UICollectionViewFlowLayout {
            //  flowLayout.estimatedItemSize = CGSize(width: 50,height: 40)
            flowLayout.headerReferenceSize = CGSize(width: 110, height: 40)
        }
        
        c_view.delegate = self
        c_view.dataSource = self
      
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
// MARK: -  UICollectionView Delegate,DataSource
extension People_Cell:UICollectionViewDelegate, UICollectionViewDataSource
{
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
             return people_arr.count
         }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
      {
          let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: C_Num_Cell.self), for: indexPath) as! C_Num_Cell
    
          if(select_people[indexPath.row] == 1)
          {
               Cell.bg_view.backgroundColor = .red
          }
          else
          {
               Cell.bg_view.backgroundColor = .gray
          }
          Cell.title.text = people_arr[indexPath.row]
          return Cell
      }
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
           select_people.removeAll()
           select_people[indexPath.row] = 1
      
           people_str = people_arr[indexPath.row]
      
           c_view.reloadData()
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

                  reusableview.title.text = "Select People"
                   return reusableview


            default:  fatalError("Unexpected element kind")
        }
        
    }
}


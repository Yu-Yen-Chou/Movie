//
//  C_Date_Cell.swift
//  Movie
//
//  Created by Yen on 2020/2/12.
//  Copyright © 2020 Yen. All rights reserved.
//

import UIKit

class C_Num_Cell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bg_view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
          
        bg_view.layer.cornerRadius = 10
        bg_view.layer.masksToBounds = false
        bg_view.layer.shadowColor = UIColor.black.cgColor
        bg_view.layer.shadowOpacity = 0.5
        bg_view.layer.shadowOffset = CGSize(width: -1, height: 1)
              
    }

}

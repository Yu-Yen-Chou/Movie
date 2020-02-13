//
//  Home_Cell.swift
//  Movie
//
//  Created by Yen on 2020/2/9.
//  Copyright © 2020 Yen. All rights reserved.
//

import UIKit

class Home_Cell: UITableViewCell {

    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var bg_view: UIView!
    @IBOutlet weak var poster_img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bg_view.layer.cornerRadius = 20
        bg_view.layer.masksToBounds = false
        bg_view.layer.shadowColor = UIColor.black.cgColor
        bg_view.layer.shadowOpacity = 0.5
        bg_view.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        poster_img.layer.cornerRadius = 10
         
        title_label.lineBreakMode = .byWordWrapping
        title_label.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

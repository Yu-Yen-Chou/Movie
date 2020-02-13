//
//  Overview_Cell.swift
//  Movie
//
//  Created by Yen on 2020/2/10.
//  Copyright © 2020 Yen. All rights reserved.
//

import UIKit

class Overview_Cell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bg_view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       bg_view.layer.cornerRadius = 20
       bg_view.layer.masksToBounds = false
       bg_view.layer.shadowColor = UIColor.black.cgColor
       bg_view.layer.shadowOpacity = 0.5
       bg_view.layer.shadowOffset = CGSize(width: -1, height: 1)
       title.lineBreakMode = .byWordWrapping
       title.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

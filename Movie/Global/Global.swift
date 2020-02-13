//
//  Global.swift
//  Movie
//
//  Created by Yen on 2020/2/9.
//  Copyright © 2020 Yen. All rights reserved.
//

import Foundation
import UIKit
 
public var G_Imgurl = "https://image.tmdb.org/t/p/w500/"
public var G_Base_Url = "https://api.themoviedb.org/3"
public var G_API_Key = "689de5ca207ece7e6038473eefc62560"
public var G_sort_by = "release_date.desc"
public var G_release_date = "2016-12-31"
public let KScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let KScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public let kScreenBounds: CGRect = UIScreen.main.bounds
public let headImageView_height  = 500
public var G_Poster_path:String?
public var G_detail_id:Int?

public var select_people = [Int:Int]()
public var select_time = [Int:Int]()
public var select_date = [Int:Int]()
public var people_str:String?
public var time_str:String?
public var time_type:String?
public var date_str:String?

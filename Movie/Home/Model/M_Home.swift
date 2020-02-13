//
//  M_Home.swift
//  Movie
//
//  Created by Yen on 2020/2/9.
//  Copyright © 2020 Yen. All rights reserved.
//

import Foundation

struct M_Home: Codable
{
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [results_array]?
  
}
struct results_array: Codable
{
     let popularity: Double?
     let vote_count: Int?
     let video: Bool?
     let poster_path: String?
     let id: Int?
     let adult: Bool?
     let backdrop_path: String?
     let original_language: String?
     let original_title: String?
     let title: String?
     let vote_average: Double?
     let overview: String?
     let release_date: String?
}

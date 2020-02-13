//
//  M_Detail.swift
//  Movie
//
//  Created by Yen on 2020/2/9.
//  Copyright © 2020 Yen. All rights reserved.
//

import Foundation

struct M_Detail: Codable
{

    let adult: Bool?
    let backdrop_path: String?
    let budget: Int?
    let genres: [genres_array]? //Genres
    let id: Int?
    let original_language: String?  //Language
    let original_title: String?
    let overview: String?  //Synopsis
    let poster_path: String?
    let runtime: Int?  //Duration
}
struct genres_array: Codable
{
    let id: Int?
    let name: String?
   
}

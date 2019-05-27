//
//  Constants.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

struct Constants {
    struct URL {
        
        static let base = "api.tvmaze.com"
        
        struct Enpoints {
            static let show = "/shows"
            static let episodes = "/episodes"
            static let seasons = "/seasons"
            static let episodeByNumber = "/episodebynumber"
            static let search = "/search/shows"
        }
        
        struct Parameters {
            static let season = "season"
            static let number = "number"
        }
    }
    
    struct Images {
        struct Episode {
            static let watched = UIImage(named: "eyeIcon")
            static let unwatched = UIImage(named: "noWatched")
        }
        
        struct Favorite {
            static let favorite = UIImage(named: "favIconFull")
            static let noFavorite = UIImage(named: "favIcon")
        }
    }
}

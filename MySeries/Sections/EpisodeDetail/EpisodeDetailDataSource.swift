//
//  EpisodeDetailDataSource.swift
//  MySeries
//
//  Created by Leticia Echarri on 28/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol EpisodeDetailDataSourceProtocol: DataSource {
    func searchEpisode(id: Int, season: Int, number: Int, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock)
}

class EpisodeDetailDataSource {
    func getURL(id: Int, season: Int, number: Int) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = Constants.URL.base
        urlComponents.path = "\(Constants.URL.Enpoints.show)/\(id)\(Constants.URL.Enpoints.episodeByNumber)"
        urlComponents.query = "\(Constants.URL.Parameters.season)=\(season)&\(Constants.URL.Parameters.number)=\(number)"
        guard let urlComplete = urlComponents.url else { fatalError("Could not create URL from components") }
        
        return urlComplete
    }
}

extension EpisodeDetailDataSource: EpisodeDetailDataSourceProtocol {
    func searchEpisode(id: Int, season: Int, number: Int,
                       success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock) {
        executeRequest(url: getURL(id: id, season: season, number: number), success: success, failure: failure)
    }
}

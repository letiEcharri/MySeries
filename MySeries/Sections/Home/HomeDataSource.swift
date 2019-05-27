//
//  HomeDataSource.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol HomeDataSourceProtocol: DataSource {
    func searchSerie(id: Int, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock)
    func searchEpisode(id: Int, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock)
}

class HomeDataSource {
    func getURL(id: Int, item: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = Constants.URL.base
        urlComponents.path = "\(Constants.URL.Enpoints.show)/\(id)\(item)"
        guard let urlComplete = urlComponents.url else { fatalError("Could not create URL from components") }
        
        return urlComplete
    }
}

extension HomeDataSource: HomeDataSourceProtocol {
    func searchSerie(id: Int, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock) {
        executeRequest(url: getURL(id: id, item: ""), success: success, failure: failure)
    }
    
    func searchEpisode(id: Int, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock) {
        executeRequest(url: getURL(id: id, item: Constants.URL.Enpoints.episodes), success: success, failure: failure)
    }
}

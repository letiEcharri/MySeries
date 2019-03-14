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
    func searchEpisode(url: String, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock)
}

class HomeDataSource {
    func getSerieURL(id: Int) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = Constants.URL.base
        urlComponents.path = "\(Constants.URL.Enpoints.show)/\(id)"
        guard let urlComplete = urlComponents.url else { fatalError("Could not create URL from components") }
        
        return urlComplete
    }
    
    func getEpisode(url: String) -> URL {
        return URL(string: url)!
    }
}

extension HomeDataSource: HomeDataSourceProtocol {
    func searchSerie(id: Int, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock) {
        executeRequest(url: getSerieURL(id: id), success: success, failure: failure)
    }
    
    func searchEpisode(url: String, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock) {
        executeRequest(url: getEpisode(url: url), success: success, failure: failure)
    }
}

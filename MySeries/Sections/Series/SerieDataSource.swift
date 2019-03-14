//
//  SerieDataSource.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 12/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol SerieDataSourceProtocol: DataSource {
    func searchSerie(id: Int, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock)
}

class SerieDataSource {
    func getURL(id: Int) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "api.tvmaze.com"
        urlComponents.path = "/shows/\(id)"
        guard let urlComplete = urlComponents.url else { fatalError("Could not create URL from components") }
        
        return urlComplete
    }
}

extension SerieDataSource: SerieDataSourceProtocol {
    
    func searchSerie(id: Int, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock) {
        executeRequest(url: getURL(id: id), success: success, failure: failure)
    }
}

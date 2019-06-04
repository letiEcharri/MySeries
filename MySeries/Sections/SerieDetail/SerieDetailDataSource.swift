//
//  SerieDetailDataSource.swift
//  MySeries
//
//  Created by Leticia Echarri on 28/05/2019.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol SerieDetailDataSourceProtocol: DataSource {
    func getCast(id: Int, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock)
}

class SerieDetailDataSource {
    func getURL(id: Int) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = Constants.URL.base
        urlComponents.path = "\(Constants.URL.Enpoints.show)/\(id)\(Constants.URL.Enpoints.cast)"
        guard let urlComplete = urlComponents.url else { fatalError("Could not create URL from components") }
        
        return urlComplete
    }
}

extension SerieDetailDataSource: SerieDetailDataSourceProtocol {
    func getCast(id: Int, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock) {
        executeRequest(url: getURL(id: id), success: success, failure: failure)
    }
}

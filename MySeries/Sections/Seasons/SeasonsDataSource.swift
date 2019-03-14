//
//  SeasonsDataSource.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 14/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation

protocol SeasonsDataSourceProtocol: DataSource {
    func getSeasons(idSerie: Int, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock)
}

class SeasonsDataSource {
    
    func getURL(id: Int) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = Constants.URL.base
        urlComponents.path = "\(Constants.URL.Enpoints.show)/\(id)\(Constants.URL.Enpoints.seasons)"
        guard let urlComplete = urlComponents.url else { fatalError("Could not create URL from components") }
        
        return urlComplete
    }
}

extension SeasonsDataSource: SeasonsDataSourceProtocol {
    
    func getSeasons(idSerie: Int, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock) {
        executeRequest(url: getURL(id: idSerie), success: success, failure: failure)
    }
}

//
//  DataSource.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 11/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

typealias SuccessCompletionBlock = (_ object: AnyObject) -> Void
typealias FailureCompletionBlock = (_ error: Error) -> Void
typealias CompletionSerieHandler = (_ serie:Serie) -> Void
typealias CompletionEpisodeHandler = (_ episode:[Episode]) -> Void

protocol DataSource {
    func executeRequest(url: URL, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock)
}

extension DataSource {
    
    func executeRequest(url: URL, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    failure(error)
                } else if let jsonData = responseData {
                    success(jsonData as AnyObject)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    failure(error)
                }
            }
        }
        
        task.resume()
    }
}

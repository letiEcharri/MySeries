//
//  DataSource.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 11/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import UIKit

typealias SuccessCompletionBlock = (_ object: Codable) -> Void
typealias FailureCompletionBlock = (_ error: Error) -> Void

protocol DataSource {
    func executeRequest(url: String, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock)
}

class SerieRequest: DataSource {
    
    func executeRequest(url: String, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "api.tvmaze.com"
        urlComponents.path = "/shows/\(4)"
        guard let urlComplete = urlComponents.url else { fatalError("Could not create URL from components") }

        var request = URLRequest(url: urlComplete)
        request.httpMethod = "GET"

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    failure(error)
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()

                    do {
                        let serie = try decoder.decode(Serie.self, from: jsonData)
                        success(serie)

                    } catch {
                        failure(error)
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    failure(error)
                }
            }
        }

        task.resume()
    }
    
}

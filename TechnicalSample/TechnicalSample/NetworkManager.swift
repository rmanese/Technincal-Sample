//
//  NetworkManager.swift
//  TechnicalSample
//
//  Created by Roberto Manese III on 4/15/19.
//  Copyright © 2019 jawnyawn. All rights reserved.
//

import Foundation

enum RequestMethods: String {
    case post = "POST"
    case get = "GET"
}

class NetworkManager {

    private let decoder = JSONDecoder()

    private let hostname = "https://lyft-interview-test.herokuapp.com/test"
    private let header: [String: String] = ["Content-Type": "application/json"]
    private let requestMethod = RequestMethods.post
    private let paramKey = "string_to_cut"

    func cutStringRequest(input: String, completionHandler: @escaping ((CutString?, Error?) -> Void)) {

        if let url = URL(string: hostname) {
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = requestMethod.rawValue
            request.allHTTPHeaderFields = header
            let paramsDict: [String: String] = [paramKey: input]
            guard let jsonData = try? JSONSerialization.data(withJSONObject: paramsDict, options: []) else {
                return
            }
            request.httpBody = jsonData
            session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let cutString = try? self.decoder.decode(CutString.self, from: data) {
                        completionHandler(cutString, error)
                    } else {
                        completionHandler(nil, error)
                    }
                }
            }.resume()
        }
    }
}

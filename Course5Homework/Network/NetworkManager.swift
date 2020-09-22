//
//  NetworkManager.swift
//  Course5Homework
//
//  Created by Андрей Груненков on 22.09.2020.
//  Copyright © 2020 Андрей Груненков. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    static var shared: NetworkManager = NetworkManager()
    
    let scheme = "https"
    let host = "api.github.com"
    let hostPath = "https://api.github.com"
    let defaultHeaders = [
        "Content-Type" : "application/json",
        "Accept" : "application/vnd.github.v3+json"
    ]
    
    let searchRepoPath = "/search/repositories"
    let userPath = "/user"
    
    let sharedSession = URLSession.shared
    
    private func performRequest(request: URLRequest,
                        completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let dataTask = sharedSession.dataTask(with: request, completionHandler: completion)
        dataTask.resume()
    }
    
    func searchRepositoriesRequest(repository: String,
                                   language: String,
                                   order: String,
                                   completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = searchRepoPath
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "\(repository)+language:\(language)"),
            URLQueryItem(name: "order", value: order)
        ]
        guard let url = urlComponents.url else {
            return
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = defaultHeaders
        performRequest(request: request, completion: completion)
    }
    
    private func makeLoginKey(username: String,
                              password: String) -> String? {
        if let key = Base64Converter.encodeStringToBase64(string: username +
                                                            ":" + password) {
            return "Basic " + key
        }
        return nil
    }
    
    func loginRequest(username: String,
                      password: String,
                      completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = userPath
        guard let url = urlComponents.url else {
            return
        }
        var request = URLRequest(url: url)
        var loginHeaders = defaultHeaders
        loginHeaders["Authorization"] = makeLoginKey(username: username,
                                                     password: password)
        request.allHTTPHeaderFields = loginHeaders
        performRequest(request: request, completion: completion)
    }
    
}

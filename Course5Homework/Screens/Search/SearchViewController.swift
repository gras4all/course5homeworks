//
//  SearchViewController.swift
//  Course5Homework
//
//  Created by Андрей Груненков on 13.09.2020.
//  Copyright © 2020 Андрей Груненков. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    
    let scheme = "https"
    let host = "api.github.com"
    let hostPath = "https://api.github.com"
    let searchRepoPath = "/search/repositories"
    let defaultHeaders = [
        "Content-Type" : "application/json",
        "Accept" : "application/vnd.github.v3+json"
    ]
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var repositoryField: UITextField!
    @IBOutlet weak var languageField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    let reposListViewController = ReposListViewController()
    
    let sharedSession = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBAction func searchBtnTap(_ sender: Any) {
        performSearchRepoRequest()
    }
    
    func searchRepositoriesRequest(repository: String, language: String, order: String) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = searchRepoPath
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "\(repository)+language:\(language)"),
            URLQueryItem(name: "order", value: order)
        ]
        guard let url = urlComponents.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = defaultHeaders
        return request
    }
    
    func performSearchRepoRequest() {
        guard let urlRequest = searchRepositoriesRequest(
            repository: repositoryField.text ?? "",
            language: languageField.text ?? "",
            order: segmentedControl.selectedSegmentIndex == 0 ? "asc" : "desc") else {
                print("url request error")
                return
        }

        let dataTask = sharedSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loadIndicator.isHidden = true
            }
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("http status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("no data received")
                return
            }
            
            guard let text = String(data: data, encoding: .utf8) else {
                print("data encoding failed")
                return
            }
            
            if let parsedResult = try? JSONDecoder().decode(ReposResponse.self, from: data) {
                self.reposListViewController.data = parsedResult
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(self.reposListViewController, animated: true)
                }
            }
            
            print("received data: \(text)")
            
        }
        loadIndicator.isHidden = false
        dataTask.resume()
    }
    
}

private extension SearchViewController {
    func setupViews() {
        let url = URL(string: "https://immedilet-invest.com/wp-content/uploads/2016/01/user-placeholder.jpg")
        avatarImage.kf.setImage(with: url)
    }
}



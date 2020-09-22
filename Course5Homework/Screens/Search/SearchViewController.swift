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

final class SearchViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var repositoryField: UITextField!
    @IBOutlet weak var languageField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    let reposListViewController = ReposListViewController()
    
    var username: String = ""
    var avatarUrl: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBAction func searchBtnTap(_ sender: Any) {
        sendSearchRepoRequest()
    }
    
    
    func sendSearchRepoRequest() {
        loadIndicator.isHidden = false
        NetworkManager
            .shared
            .searchRepositoriesRequest(repository: repositoryField.text ?? "",
                                       language: languageField.text ?? "",
                                       order: segmentedControl.selectedSegmentIndex == 0 ? "asc" : "desc") {
                [weak self] (data, response, error) in
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
    }
}

private extension SearchViewController {
    func setupViews() {
        helloLabel.text = "Hello \(username)!"
        let url = URL(string: avatarUrl)
        avatarImage.kf.setImage(with: url)
    }
}



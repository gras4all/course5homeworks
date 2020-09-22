//
//  ViewController.swift
//  Course5Homework
//
//  Created by Андрей Груненков on 13.09.2020.
//  Copyright © 2020 Андрей Груненков. All rights reserved.
//

import UIKit
import Kingfisher

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBAction func loginBtnTap(_ sender: Any) {
        loadIndicator.isHidden = false
        NetworkManager.shared.loginRequest(username: loginField.text ?? "",
                                           password: passwordField.text ?? "",
                                           completion: { [weak self] (data, response, error) in
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
                                            print(text)
                                            if let parsedResult = try? JSONDecoder().decode(LoginData.self, from: data) {
                                                DispatchQueue.main.async {
                                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                    let searchViewController = storyboard.instantiateViewController(withIdentifier: String(describing: SearchViewController.self)) as! SearchViewController
                                                    
                                                    searchViewController.username = parsedResult.login
                                                    searchViewController.avatarUrl = parsedResult.avatarUrl
                                                    self.navigationController?.pushViewController(searchViewController, animated: true)
                                                }   
                                            }
                                            
                                           })
    }
    
}

private extension LoginViewController {
    func setupViews() {
        let url = URL(string: "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png")
        logoImageView.kf.setImage(with: url)
    }
}


//
//  ViewController.swift
//  Course5Homework
//
//  Created by Андрей Груненков on 13.09.2020.
//  Copyright © 2020 Андрей Груненков. All rights reserved.
//

import UIKit
import Kingfisher

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBAction func loginBtnTap(_ sender: Any) {
    }
    


}

private extension LoginViewController {
    func setupViews() {
        let url = URL(string: "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png")
        logoImageView.kf.setImage(with: url)
    }
}


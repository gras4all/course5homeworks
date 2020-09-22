//
//  WebKitViewController.swift
//  Course5Homework
//
//  Created by Андрей Груненков on 20.09.2020.
//  Copyright © 2020 Андрей Груненков. All rights reserved.
//

import Foundation
import UIKit
import WebKit

final class WebKitViewController: UIViewController, WKNavigationDelegate {
    
    var url: URL?
    var repoName: String?
    
    var webKitView: WKWebView = {
        let wkwebview = WKWebView()
        wkwebview.translatesAutoresizingMaskIntoConstraints = false
        return wkwebview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        if let url = url {
            webKitView.load(URLRequest(url: url))
        }
    }
    
    func webView(_ webView: WKWebView,
        didFinish navigation: WKNavigation!) {
        let changeBgScript = "document.body.style.background = \"SALMON\""
        self.webKitView.evaluateJavaScript(changeBgScript) { (result, error) in
            if error != nil {
                print("\(error)")
            }
        }
      }
    
}

private extension WebKitViewController {
    
    func setupViews() {
        self.view.backgroundColor = UIColor.white
        view.addSubview(webKitView)
        webKitView.navigationDelegate = self
        if let repoName = repoName {
            title = repoName
        }
    }
    
    func setupConstraints() {
        [webKitView.topAnchor.constraint(equalTo: view.safeTopAnchor),
         webKitView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
         webKitView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
         webKitView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
         ].forEach { $0.isActive = true }
    }
    
}

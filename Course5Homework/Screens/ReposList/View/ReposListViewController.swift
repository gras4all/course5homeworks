//
//  RepoListViewController.swift
//  Course5Homework
//
//  Created by Андрей Груненков on 14.09.2020.
//  Copyright © 2020 Андрей Груненков. All rights reserved.
//

import Foundation
import UIKit

final class ReposListViewController: UIViewController {
    
    private let navBarTitle = "Repos"
    
    lazy var reposTableView: UITableView  = {
        let tableView = UITableView()
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelection = false
        tableView.isExclusiveTouch = true
        return tableView
    }()
    
    var data: ReposResponse!
    
    var headerView: ReposHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        headerView.configureTitle("Repositories found: \(data.count)")
        reposTableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: reposTableView.tableHeaderView)
    }

    private func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width - 32.0, height: 0)).height
    }
    
}

extension ReposListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoCell.self)) as! RepoCell
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.bindData(data.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableCellHeight
    }
    
}

private extension ReposListViewController {
    
    var tableCellHeight: CGFloat {
        return 90
    }
    
    func setupViews() {
        self.view.backgroundColor = UIColor.white
        view.addSubview(reposTableView)
        title = navBarTitle
        reposTableView.delegate = self
        reposTableView.dataSource = self
        reposTableView.register(RepoCell.self, forCellReuseIdentifier: String(describing: RepoCell.self))
        headerView = ReposHeaderView(frame: .zero)
        reposTableView.tableHeaderView = headerView
    }
    
    func setupConstraints() {
        [reposTableView.topAnchor.constraint(equalTo: view.safeTopAnchor),
         reposTableView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor),
         reposTableView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
         reposTableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
         ].forEach { $0.isActive = true }
    }
    
}

//
//  WeekViewController.swift
//  Rainstorm
//
//  Created by Alves Jorge on 30/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

protocol WeekViewControllerDelegate: class {
    func controllerDidRefresh(_ viewController: WeekViewController)
}

final class WeekViewController: UIViewController {
    
    weak var refreshDelegate: WeekViewControllerDelegate?
    
    var viewModel: WeekViewModel? {
        didSet {
            if let viewModel = viewModel {
                refreshControl.endRefreshing()
                setupViewModel(viewModel)
            }
        }
    }
    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = UIColor.Rainstorm.base
        refresh.addTarget(self, action: #selector(refreshWeek), for: .valueChanged)
        return refresh
    }()
    
    private let weekWeatherTableView: WeekWeatherTableViewController = {
        let tableView = WeekWeatherTableViewController()
        tableView.tableView.isHidden = true
        tableView.tableView.separatorInset = .zero
        tableView.tableView.estimatedRowHeight = 44.0
        tableView.tableView.rowHeight = UITableView.automaticDimension
        tableView.tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let activityController: ActivityIndicatorController = {
        let controller = ActivityIndicatorController()
        controller.view.isHidden = false
        return controller
    }()
    
    
//    let activityIndicator: UIActivityIndicatorView = {
//        let acitivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
//        acitivityIndicator.tintColor = UIColor.Rainstorm.base
//        acitivityIndicator.startAnimating()
//        acitivityIndicator.hidesWhenStopped = true
//        return acitivityIndicator
//    }()
    
    // MARK: - View Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        weekWeatherTableView.tableView.refreshControl = refreshControl
    }
    
    
    // MARK: - Helper methods
    
    private func setupViewModel(_ viewModel: WeekViewModel) {
        activityController.view.isHidden = true
        weekWeatherTableView.tableView.isHidden = false
        weekWeatherTableView.weekViewModel = viewModel
    }
    
    @objc private func refreshWeek() {
        refreshDelegate?.controllerDidRefresh(self)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        
        addChild(weekWeatherTableView)
        addChild(activityController)
        
        view.addSubview(weekWeatherTableView.tableView)
        weekWeatherTableView.tableView.fillSuperview()
        view.addSubview(activityController.view)
        
        activityController.didMove(toParent: self)
        weekWeatherTableView.didMove(toParent: self)
    }

}


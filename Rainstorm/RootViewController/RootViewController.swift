//
//  RootViewController.swift
//  Rainstorm
//
//  Created by Alves Jorge on 30/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    private enum AlertType {
        case noWeatherDataAvailable
        case failedToRequestLocation
        case notAuthorizedToRequestLocation
    }
    
    // MARK: - Properties
    
    let viewModel: RootViewModel
    
    private let dayViewController: DayViewController = {
        let dayViewController = DayViewController()
        
        return dayViewController
    }()
    
    private lazy var weekViewController: WeekViewController = {
        let weekViewController = WeekViewController()
        weekViewController.refreshDelegate = self
        return weekViewController
    }()
    
    private let noLocationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    private let noLocationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Unable to get location \nRainstorm needs to access your location in order to fetch weather data"
        label.numberOfLines = 0
        return label
    }()
    
    
    
    
    init(rootViewModel: RootViewModel) {
        self.viewModel = rootViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupChildViewControllers()
        viewModel.refresh()
        
        viewModel.didFetchWeatherData = { [weak self] result in
            guard let self = self else { return }
            
            
            switch result {
            case .success(let weatherData):
                let dayViewModel = DayViewModel(weatherData: weatherData.current)
                let weekViewModel = WeekViewModel(weatherData: weatherData.forecast)
                self.dayViewController.viewModel = dayViewModel
                self.weekViewController.viewModel = weekViewModel
                self.updateViews(false)
            case .failure(let error as WeatherDataError):
                let alert: AlertType
                switch error {
                case .noWeatherDataAvailable:
                    alert = .noWeatherDataAvailable
                case .notAuthorizedToRequestLocation:
                    self.updateViews(true)
                    alert = .notAuthorizedToRequestLocation
                case .failedToRequestLocation:
                    self.updateViews(true)
                    alert = .failedToRequestLocation
                }
                self.dayViewController.viewModel = nil
                self.weekViewController.viewModel = nil
                self.presentAlert(of: alert)
            default: return
            }
        }
    }
    
    
    // MARK: - Help methods
    
    private func setupChildViewControllers() {
        addChild(dayViewController)
        addChild(weekViewController)
        
        view.addSubview(dayViewController.view)
        view.addSubview(weekViewController.view)
        
        dayViewController.view.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.zero, size: .zero)
        
        weekViewController.view.anchor(top: dayViewController.view.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets.zero, size: .zero)
        
        view.addSubview(noLocationView)
        noLocationView.fillSuperview()
        noLocationView.addSubview(noLocationLabel)
        
        noLocationLabel.anchor(top: noLocationView.topAnchor, leading: noLocationView.leadingAnchor, bottom: nil, trailing: noLocationView.trailingAnchor, padding: UIEdgeInsets(top: 200, left: 30, bottom: 0, right: 30), size: .zero)
        
        dayViewController.didMove(toParent: self)
        weekViewController.didMove(toParent: self)
    }
    
    private func updateViews(_ hasFailed: Bool) {
        if hasFailed {
            noLocationView.isHidden = false
            dayViewController.view.isHidden = true
            weekViewController.view.isHidden = true
        } else {
            noLocationView.isHidden = true
            dayViewController.view.isHidden = false
            weekViewController.view.isHidden = false
        }
    }
    
    private func presentAlert(of alertType: AlertType) {
        let title: String
        let message: String
        switch alertType {
        case .noWeatherDataAvailable:
            title =  "Unable to fetch weather data"
            message = "The application is unable to fetch weather data, please make sure your device has connection"
        case .notAuthorizedToRequestLocation:
            title = "Unable to get location"
            message = "Rainstorm needs to access your location in order to fetch weather data"
        case .failedToRequestLocation:
            title = "Unable to get location"
            message = "Location request has failed"
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }


}

extension RootViewController: WeekViewControllerDelegate {
    func controllerDidRefresh(_ viewController: WeekViewController) {
        print("refreshing")
        viewModel.refresh()
        
    }
}

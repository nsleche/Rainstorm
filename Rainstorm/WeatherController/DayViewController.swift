//
//  DayViewController.swift
//  Rainstorm
//
//  Created by Alves Jorge on 30/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

final class DayViewController: UIViewController {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Rainstorm.base
        label.font = UIFont.Rainstorm.heavyLarge
        label.textAlignment = .center
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.Rainstorm.lightSmall
        return label
    }()
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = iv.image?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.Rainstorm.base
        return iv
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.Rainstorm.lightRegular
        return label
    }()
    
    let windspeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.Rainstorm.lightRegular
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.Rainstorm.lightRegular
        return label
    }()
    
    let acitivityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        indicator.color = UIColor.Rainstorm.base
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var viewModel: DayViewModel? {
        didSet {
            if let viewModel = viewModel {
                self.setupViewModel(with: viewModel)
            }
        }
    }

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Helper methods
    
    private func setupView() {
        view.backgroundColor = UIColor.Rainstorm.lightBackgroundColor
        view.addSubview(acitivityIndicatorView)
        view.addSubview(dateLabel)
        view.addSubview(timeLabel)
        view.addSubview(iconImageView)
        view.addSubview(temperatureLabel)
        view.addSubview(windspeedLabel)
        view.addSubview(descriptionLabel)
        acitivityIndicatorView.centerInSuperview()
        dateLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20), size: .zero)
        timeLabel.anchor(top: dateLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20), size: .zero)
        iconImageView.anchor(top: timeLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 60, height: 60))
        iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0), size: .zero)
        temperatureLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        windspeedLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16), size: .zero)
        windspeedLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        descriptionLabel.anchor(top: iconImageView.bottomAnchor, leading: nil, bottom: view.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0), size: .zero)
        descriptionLabel.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor).isActive = true
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func setupViewModel(with viewModel: DayViewModel) {
        acitivityIndicatorView.stopAnimating()
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        iconImageView.image = viewModel.image
        temperatureLabel.text = viewModel.temperature
        windspeedLabel.text = viewModel.windspeed
        descriptionLabel.text = viewModel.summary
        
    }

}

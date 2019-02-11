//
//  WeekCell.swift
//  Rainstorm
//
//  Created by Alves Jorge on 03/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

class WeekCell: UITableViewCell, ReusableCell {
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Rainstorm.base
        label.font = UIFont.Rainstorm.heavyLarge
        label.textAlignment = .left
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
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




    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupView() {
        addSubview(dayLabel)
        addSubview(dateLabel)
        addSubview(temperatureLabel)
        addSubview(windspeedLabel)
        addSubview(iconImageView)
        print("setting it up")
        dayLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0), size: .zero)
        dateLabel.anchor(top: dayLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0), size: .zero)
        temperatureLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0), size: .zero)
        iconImageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 10), size: CGSize(width: 60, height: 60))
        windspeedLabel.anchor(top: iconImageView.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10), size: .zero)
    }
    
    
    func configure(with viewModel: WeekDayRepresentable) {
        dayLabel.text = viewModel.day
        dateLabel.text = viewModel.date
        temperatureLabel.text = viewModel.temperature
        iconImageView.image = viewModel.image
        windspeedLabel.text = viewModel.windspeed
    }

}

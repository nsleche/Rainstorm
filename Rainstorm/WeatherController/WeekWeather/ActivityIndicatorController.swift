//
//  ActivityIndicatorController.swift
//  Rainstorm
//
//  Created by Alves Jorge on 03/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

class ActivityIndicatorController: UIViewController {
    
    let acitivityIndicator: UIActivityIndicatorView = {
        let acitivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        acitivityIndicator.color = UIColor.Rainstorm.base
        acitivityIndicator.startAnimating()
        acitivityIndicator.hidesWhenStopped = true
        return acitivityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(acitivityIndicator)
        acitivityIndicator.centerInSuperview()
    }
    

}
